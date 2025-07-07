#!/bin/bash

echo $MY_ENV_DIR
echo $AWS_ACCESS_KEY_ID

# cd $MY_ENV_DIR/aws_mysql_bulkload/aws-profile
# . ./set_up.sh

cd $MY_ENV_DIR/aws_mysql_bulkload/make_data
. ./set_up.sh

cd $MY_ENV_DIR/aws_mysql_bulkload/create_tables
. ./set_up.sh

cd $MY_ENV_DIR/aws_mysql_bulkload/load_data
. ./set_up.sh

cd $MY_ENV_DIR/aws_mysql_bulkload/spring-batch-processing
. ./set_up.sh

cd $MY_ENV_DIR/aws_mysql_bulkload/row_count
. ./set_up.sh


