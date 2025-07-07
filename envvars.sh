#!/bin/bash
set -euo pipefail

# === Configuration ===
DB_INSTANCE_IDENTIFIER="wordpress"
CSV_FILE="$MY_ENV_DIR/data.csv"
TABLE_NAME="my_table"

# === Step 1: Get RDS endpoint ===
echo "🔍 Fetching RDS endpoint..."
export DB_HOST=$(aws rds describe-db-instances \
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

export DB_USER=$(echo "$SECRET_JSON" | jq -r '.username')
export DB_PASSWORD=$(echo "$SECRET_JSON" | jq -r '.password')
# DB_NAME=$(echo "$SECRET_JSON" | jq -r '.dbname')
DB_NAME=wordpress
export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY

 
