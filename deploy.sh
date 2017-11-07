#!/bin/bash
#
# Copyright 2017 IBM Corp. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the “License”);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#  https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an “AS IS” BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Load configuration variables
source local.env

function usage() {
  echo -e "Usage: $0 [--install,--uninstall,--env]"
}

function install() {
  # Exit if any command fails
  set -e

  echo -e "Installing OpenWhisk actions, triggers, and rules for openwhisk-serverless-apis..."

  echo -e "Setting Bluemix credentials and logging in to provision API Gateway"

  # Edit these to match your Bluemix credentials (needed to provision the API Gateway)
  wsk bluemix login \
    --user $BLUEMIX_USERNAME \
    --password $BLUEMIX_PASSWORD \
    --namespace $BLUEMIX_NAMESPACE

  echo -e "\n"

  echo "Installing GET fibonacci Action"
  cd actions/fibonacci
  # preserve dev deps
  mkdir -p node_modules
  mv node_modules .mod
  # install only prod deps
  npm install --only=production
  # zip all but skip the dev deps
  zip -rq action.zip package.json lib node_modules
  # delete prod deps
  rm -rf node_modules
  # recover dev deps
  mv .mod node_modules
  # install zip in openwhisk
  wsk action create fibonacci-get \
    --kind nodejs:6 action.zip \
    --web true
  wsk api create -n "Fibonacci API" /v1 /fibonacci get fibonacci-get
  cd ../..

  echo -e "Install Complete"
}

function uninstall() {
  echo -e "Uninstalling..."

  echo "Removing API actions..."
  wsk api delete /v1

  echo "Removing actions..."
  wsk action delete fibonacci-get

  echo -e "Uninstall Complete"
}

function showenv() {
  echo -e BLUEMIX_USERNAME="$BLUEMIX_USERNAME"
  echo -e BLUEMIX_PASSWORD="$BLUEMIX_PASSWORD"
  echo -e BLUEMIX_PASSWORD="$BLUEMIX_NAMESPACE"
}

case "$1" in
"--install" )
install
;;
"--uninstall" )
uninstall
;;
"--env" )
showenv
;;
* )
usage
;;
esac
