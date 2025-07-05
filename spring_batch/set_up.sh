#!/bin/bash

sudo yum install maven -y
cd /home/ec2-user/environment/gs-batch-processing/complete/
mvn clean package
