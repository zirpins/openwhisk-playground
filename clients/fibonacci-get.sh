#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo -e "Usage: $0 [index]"
    exit
fi

FIBONACCI_API_URL=`wsk api-experimental list | tail -1 | awk '{print $5}'`

curl ${FIBONACCI_API_URL}?index=${1}