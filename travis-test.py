##############################################################################
# Copyright 2017 IBM Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
##############################################################################

import os
import requests
import json
import time
from subprocess import call

FIBONACCI_API_URL = os.environ['FIBONACCI_API_URL']
print "FIBONACCI_API_URL is: " + FIBONACCI_API_URL

def main():
	checkFibonacci(25, 75025)

def checkFibonacci(index, number):
	print("Verify that 25th fibonacci number is 75025 (GET)")
	response=requests.get(FIBONACCI_API_URL+"?index="+str(index))
	result = json.loads(response.text)

	if response.status_code != 200 or \
	   not 'index' in result or \
	   result["index"] != index or \
	   result["number"] != number:
	   	print("Failed to verify fibonacci computation. Response: " + response.text)
	   	exit(1)

	print("success")

main()
