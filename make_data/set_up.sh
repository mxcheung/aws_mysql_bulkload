#!/bin/bash

echo "✅ Creating data.csv"

python3 make_data.py
cp data.csv $MY_ENV_DIR/data.csv
wc -l $MY_ENV_DIR/data.csv
