#!/bin/bash

set -e

echo "Deploying wsk actions, etc."
./deploy.sh --install

echo "Find and set Fibonacci API URL"
export FIBONACCI_API_URL=`wsk api list | grep fibonacci | awk '{print $5}'`

echo "Running pythontests"
python3 travis-test.py

echo "Uninstalling wsk actions, etc."
./deploy.sh --uninstall
