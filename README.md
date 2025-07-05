# aws_mysql_bulkload
aws_mysql_bulkload

# 
```
git clone https://github.com/mxcheung/aws_mysql_bulkload.git
cd /home/ec2-user/environment/aws_mysql_bulkload/
. ./set_up.sh
```



# Quick start
Hosting a Wordpress Application on ECS Fargate with RDS, Parameter Store, and Secrets Manager

https://github.com/mxcheung/aws-ecs/tree/main/word_press_ecs

# Connect Cloud9 to RDS
get credential in secret manager
https://us-east-1.console.aws.amazon.com/secretsmanager/home?region=us-east-1#
```
mysql -h your-db-endpoint.rds.amazonaws.com -u admin -p
```


# Prepare Your Table in RDS
USE wordpress;
```
CREATE TABLE my_table (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    created_at DATETIME
);
```


```
MySQL [wordpress]> 
MySQL [wordpress]> 
MySQL [wordpress]> CREATE TABLE my_table (
    ->     id INT PRIMARY KEY,
    ->     name VARCHAR(100),
    ->     email VARCHAR(100),
    ->     created_at DATETIME
    -> );
Query OK, 0 rows affected (0.028 sec)
```


# create dummy csv

```
cat <<EOF > data.csv
id,name,email,created_at
EOF

for i in $(seq 1 1000000); do
  echo "$i,User$i,user$i@example.com,$(date -d "$i days ago" '+%Y-%m-%d %H:%M:%S')" >> data.csv
done
```

# check data file

```
cloud_user:~/environment/py2 $ wc -lc data.csv 
 1000001 61666714 data.csv
```
