#!/bin/bash

sudo yum install maven -y

cd $MY_ENV_DIR/aws_mysql_bulkload/spring-batch-processing
mvn clean package

java -jar ./target/batch-processing-complete-0.0.1-SNAPSHOT.jar