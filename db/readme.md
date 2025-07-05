

```
 ./set_up.sh /home/ec2-user/environment/data2.csv wordpress my_table wordpress.ceqjzs3tiux1.us-east-1.rds.amazonaws.com admin
```


```
RDS_ENDPOINT=$(aws rds describe-db-instances --db-instance-identifier wordpress --query 'DBInstances[0].Endpoint.Address' --output text)
SECRET_ARN=$(aws rds describe-db-instances --db-instance-identifier wordpress --query 'DBInstances[0].MasterUserSecret.SecretArn' --output text)
SECRET_NAME=$(aws secretsmanager describe-secret --secret-id $SECRET_ARN --query 'Name' --output text)
SECRET_STRING=$(aws secretsmanager get-secret-value   --secret-id "$SECRET_ARN"   --query 'SecretString'   --output text)
DB_PASSWORD=$(echo "$SECRET_STRING" | jq -r '.password')
DB_USERNAME=$(echo "$SECRET_STRING" | jq -r '.username')
echo "RDS_ENDPOINT: $RDS_ENDPOINT"
echo "Password: $DB_PASSWORD"
```
