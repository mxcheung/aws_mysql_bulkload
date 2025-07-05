# aws_mysql_bulkload
aws_mysql_bulkload

# 

```
git clone https://github.com/mxcheung/aws-ecs.git
cd /home/cloudshell-user/aws-ecs/word_press_ecs/user_credentials/

response=$(aws iam create-access-key --output json)

# Write the response to a JSON file
echo "$response" > access-key-response.json

# Extract AccessKeyId and SecretAccessKey from the response file
access_key_id=$(jq -r '.AccessKey.AccessKeyId' access-key-response.json)
secret_access_key=$(jq -r '.AccessKey.SecretAccessKey' access-key-response.json)

# Print the extracted values (optional)
echo "AccessKeyId: $access_key_id"
echo "SecretAccessKey: $secret_access_key"


cd /home/cloudshell-user/aws-ecs/word_press_ecs/user_credentials/
. ./set_up.sh
cd /home/cloudshell-user/aws-ecs/word_press_ecs/
. ./set_up.sh
```

```
cloudshell - HOME="/home/cloudshell-user"
export MY_ENV_DIR="$HOME"
cloud9 - HOME="/home/ec2-user"

cd $MY_ENV_DIR/aws_mysql_bulkload/load_data
. ./set_up.sh
```

cd /home/cloudshell-user/
```
export MY_ENV_DIR="$HOME/environment"
echo $MY_ENV_DIR
cd $MY_ENV_DIR
git clone https://github.com/spring-guides/gs-batch-processing.git
git clone https://github.com/mxcheung/aws_mysql_bulkload.git
cd $MY_ENV_DIR/aws_mysql_bulkload/
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
