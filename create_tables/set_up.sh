#!/bin/bash
set -euo pipefail

# === Configuration ===
DB_INSTANCE_IDENTIFIER="wordpress"
CSV_FILE="$MY_ENV_DIR/data.csv"
TABLE_NAME="my_table"

# === Step 1: Get RDS endpoint ===
echo "🔍 Fetching RDS endpoint..."
DB_HOST=$(aws rds describe-db-instances \
  --db-instance-identifier "$DB_INSTANCE_IDENTIFIER" \
  --query 'DBInstances[0].Endpoint.Address' \
  --output text)

echo "✅ RDS endpoint: $DB_HOST"

# === Step 2: Get DB credentials from Secrets Manager ===
echo "🔐 Fetching database credentials from Secrets Manager..."

SECRET_ARN=$(aws rds describe-db-instances \
  --db-instance-identifier "$DB_INSTANCE_IDENTIFIER" \
  --query 'DBInstances[0].MasterUserSecret.SecretArn' \
  --output text)

SECRET_JSON=$(aws secretsmanager get-secret-value \
  --secret-id "$SECRET_ARN" \
  --query 'SecretString' \
  --output text)

DB_USER=$(echo "$SECRET_JSON" | jq -r '.username')
DB_PASSWORD=$(echo "$SECRET_JSON" | jq -r '.password')
# DB_NAME=$(echo "$SECRET_JSON" | jq -r '.dbname')
DB_NAME=wordpress

echo "✅ Retrieved credentials for user: $DB_USER, database: $DB_NAME"

# === Step 3: Load CSV into MySQL table ===
echo "📥 Creating tables $DB_NAME.mytable on $DB_HOST..."

mysql --local-infile=1   -h "$DB_HOST"   -u "$DB_USER"  -p"$DB_PASSWORD"  "$DB_NAME" <<EOF

use wordpress;

CREATE TABLE my_table (
  id INT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100),
  created_at DATETIME
);

EOF


echo "✅ Create tables complete."
