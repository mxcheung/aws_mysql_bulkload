#!/bin/bash

echo $MY_ENV_DIR

cd $MY_ENV_DIR/aws_mysql_bulkload/make_data
. ./set_up.sh


cd $MY_ENV_DIR/aws_mysql_bulkload/load_data
. ./set_up.sh
