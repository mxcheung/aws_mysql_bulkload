

```
 ./set_up.sh /home/ec2-user/environment/data2.csv wordpress my_table wordpress.ceqjzs3tiux1.us-east-1.rds.amazonaws.com admin
```


```
RDS_ENDPOINT=$(aws rds describe-db-instances \
  --db-instance-identifier wordpress \
  --query 'DBInstances[0].Endpoint.Address' \
  --output text)

echo $RDS_ENDPOINT
```
