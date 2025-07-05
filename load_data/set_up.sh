#!/bin/bash

# Usage: ./load_data.sh data.csv mydb my_table your-db-endpoint your-username

DATA_FILE=$1
DATABASE=$2
TABLE=$3
HOST=$4
USER=$5

if [[ -z "$DATA_FILE" || -z "$DATABASE" || -z "$TABLE" || -z "$HOST" || -z "$USER" ]]; then
  echo "Usage: $0 <data_file.csv> <database> <table> <db_host> <db_user>"
  exit 1
fi

if [[ ! -f "$DATA_FILE" ]]; then
  echo "Data file '$DATA_FILE' not found!"
  exit 2
fi

echo -n "Enter password for MySQL user '$USER': "
read -s PASSWORD
echo

mysql --host="$HOST" --user="$USER" --password="$PASSWORD" --database="$DATABASE" --local-infile=1 -e "
LOAD DATA LOCAL INFILE '$DATA_FILE'
INTO TABLE $TABLE
FIELDS TERMINATED BY ',' 
ENCLOSED BY '\"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES
;
"

if [[ $? -eq 0 ]]; then
  echo "Data loaded successfully into $DATABASE.$TABLE"
else
  echo "Failed to load data."
fi
