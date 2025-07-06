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

# cloud shell get access key
No, you cannot currently access resources that are in your private VPC in this release of CloudShell.
https://repost.aws/questions/QUUUbxosRsQH-wzS3DmpnvxQ/how-to-get-to-mysql-prompt-using-cloudshell
cloudshell - HOME="/home/cloudshell-user"
```

response=$(aws iam create-access-key --output json)

# Write the response to a JSON file
echo "$response" > access-key-response.json

# Extract AccessKeyId and SecretAccessKey from the response file
access_key_id=$(jq -r '.AccessKey.AccessKeyId' access-key-response.json)
secret_access_key=$(jq -r '.AccessKey.SecretAccessKey' access-key-response.json)

# Print the extracted values (optional)
echo "AccessKeyId: $access_key_id"
echo "SecretAccessKey: $secret_access_key"
```


# cloud 9 load data
```
export AWS_ACCESS_KEY_ID=xxxxxxxxxxxxxxxxxxx
export AWS_SECRET_ACCESS_KEY=xxxxxxxxxxxxxxxxxxxxxxxxxxxx
aws sts get-caller-identity
export MY_ENV_DIR="$HOME/environment"
git clone https://github.com/mxcheung/aws_mysql_bulkload.git
echo $MY_ENV_DIR
cd $MY_ENV_DIR/aws_mysql_bulkload/
. ./set_up.sh
```

# cloud 9 install java
```
export MY_ENV_DIR="$HOME/environment"
git clone https://github.com/spring-guides/gs-batch-processing.git
echo $MY_ENV_DIR
cd $MY_ENV_DIR/aws_mysql_bulkload/
. ./set_up_java.sh
```

```
cloud_user:~/environment/gs-batch-processing/complete (main) $ java -jar ./target/batch-processing-complete-0.0.1-SNAPSHOT.jar

  .   ____          _            __ _ _
 /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
 \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  '  |____| .__|_| |_|_| |_\__, | / / / /
 =========|_|==============|___/=/_/_/_/

 :: Spring Boot ::                (v3.5.3)

2025-07-06T08:18:33.999Z  INFO 5923 --- [           main] c.e.b.JobCompletionNotificationListener  : Found <Person[firstName=JOHN, lastName=DOE]> in the database.
2025-07-06T08:18:34.007Z  INFO 5923 --- [           main] o.s.b.c.l.s.TaskExecutorJobLauncher      : Job: [SimpleJob: [name=importUserJob]] completed with the following parameters: [{}] and the following status: [COMPLETED] in 109ms
2025-07-06T08:18:34.015Z  INFO 5923 --- [           main] com.zaxxer.hikari.HikariDataSource       : HikariPool-1 - Shutdown initiated...
2025-07-06T08:18:34.020Z  INFO 5923 --- [           main] com.zaxxer.hikari.HikariDataSource       : HikariPool-1 - Shutdown completed.
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


# Load Data via cloud 9
```
cloud_user:~/environment $ cd $MY_ENV_DIR/aws_mysql_bulkload/
cloud_user:~/environment/aws_mysql_bulkload (main) $ . ./set_up.sh
/home/ec2-user/environment
✅ Creating data.csv
1000001 /home/ec2-user/environment/data.csv
🔍 Fetching RDS endpoint...
✅ RDS endpoint: wordpress.cbsg8t75jjai.us-east-1.rds.amazonaws.com
🔐 Fetching database credentials from Secrets Manager...
✅ Retrieved credentials for user: admin, database: wordpress
📥 Loading /home/ec2-user/environment/data.csv into wordpress.my_table on wordpress.cbsg8t75jjai.us-east-1.rds.amazonaws.com...
✅ Data load complete.
🔍 Fetching RDS endpoint...
✅ RDS endpoint: wordpress.cbsg8t75jjai.us-east-1.rds.amazonaws.com
🔐 Fetching database credentials from Secrets Manager...
✅ Retrieved credentials for user: admin, database: wordpress
📥 Checing row count wordpress.my_table on wordpress.cbsg8t75jjai.us-east-1.rds.amazonaws.com...
count(*)
1000000
✅ Check row count complete.
cloud_user:~/environment/aws_mysql_bulkload/row_count (main) $ 

MySQL [wordpress]> select count(*) from my_table;
+----------+
| count(*) |
+----------+
|  1000000 |
+----------+
1 row in set (0.094 sec)

```
