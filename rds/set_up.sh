echo "Create the RDS Instance -> aws rds create-db-instance"

# Create the RDS Instance
CREATE_RDS_OUTPUT=$(aws rds create-db-instance \
    --db-instance-identifier wordpress \
    --db-instance-class db.t4g.micro \
    --db-name wordpress \
    --engine mysql \
    --engine-version 8.0.35 \
    --allocated-storage 20 \
    --storage-type gp3 \
    --allocated-storage 20 \
    --kms-key-id $RDS_KMS_KEY_ID \
    --max-allocated-storage 1000 \
    --db-subnet-group-name database-subnet-group \
    --storage-encrypted \
    --backup-retention-period 0 \
    --vpc-security-group-ids $DATABASE_SG_ID \
    --master-username admin \
    --manage-master-user-password)
