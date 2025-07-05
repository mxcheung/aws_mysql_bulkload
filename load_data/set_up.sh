#!/bin/bash
set -euo pipefail

# === Configuration ===
DB_INSTANCE_IDENTIFIER="wordpress"
CSV_FILE="/home/ec2-user/environment/data.csv"
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
DB_NAME=$(echo "$SECRET_JSON" | jq -r '.dbname')

echo "✅ Retrieved credentials for user: $DB_USER, database: $DB_NAME"

# === Step 3: Load CSV into MySQL table ===
echo "📥 Loading $CSV_FILE into $DB_NAME.$TABLE_NAME on $DB_HOST..."

mysql --local-infile=1 \
  -h "$DB_HOST" \
  -u "$DB_USER" \
  -p"$DB_PASSWORD" \
  "$DB_NAME" <<EOF
LOAD DATA LOCAL INFILE '$CSV_FILE'
INTO TABLE $TABLE_NAME
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
EOF

echo "✅ Data load complete."
