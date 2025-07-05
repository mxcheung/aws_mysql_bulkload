#!/bin/bash

sudo yum install maven -y
cd $MY_ENV_DIR/gs-batch-processing/complete/

mvn clean package
