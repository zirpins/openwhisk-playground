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
  echo -e "Installing OpenWhisk actions, triggers, and rules for openwhisk-playground.."

  echo "Installing GET fibonacci Action"
  cd actions/fibonacci
  npm install
  zip -rq action.zip *
  wsk action create fibonacci-get --kind nodejs:6 action.zip
  wsk api-experimental create /v1 /fibonacci get fibonacci-get
  cd ../..

  echo -e "Install Complete"
}

function uninstall() {
  echo -e "Uninstalling..."

  echo "Removing API actions..."
  wsk api-experimental delete /v1

  echo "Removing actions..."
  wsk action delete fibonacci-get

  echo -e "Uninstall Complete"
}

function showenv() {
  echo -e MY_VARIABLE="$MY_VARIABLE"
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