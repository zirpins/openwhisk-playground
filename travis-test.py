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

FIBONACCI_API_URL = os.environ['FIBONACCI_API_URL']
print("FIBONACCI_API_URL is: " + FIBONACCI_API_URL)

FIBONACCI_API_WEB_URL = "https://openwhisk.ng.bluemix.net/api/v1/web/IWIbot_dev/fibonacci_package/fibonacci-get"
print("FIBONACCI_API_WEB_URL is: " + FIBONACCI_API_WEB_URL)

def main():
    checkBadIndex()
    checkFibonacci(25, 75025)

def checkBadIndex():
    print("Verify that a bad index (below 1) will fail (GET)")
    response = requests.get(FIBONACCI_API_WEB_URL+"?index=-1")
    result = json.loads(response.text)
    print("Response: (" + str(response.status_code) + ") " + response.text)
    if response.status_code != 502 \
      or "error" not in result \
      or result["error"] != "index too small":
        print("Failed to verify bad index.")
        exit(1)
    print("success")

def checkFibonacci(index, number):
    print("Verify that 25th fibonacci number is 75025 (GET)")
    response = requests.get(FIBONACCI_API_URL+"?index="+str(index))
    result = json.loads(response.text)
    content = result["body"]
    print("Response: (" + str(response.status_code) + ") " + response.text)
    if response.status_code != 200 \
      or 'index' not in content \
      or 'number' not in content \
      or content["index"] != index \
      or content["number"] != number:
        print("Failed to verify fibonacci computation.")
        exit(1)
    print("success")

main()
