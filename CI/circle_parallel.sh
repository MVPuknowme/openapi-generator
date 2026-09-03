#!/bin/bash
#
# A bash script to run CircleCI node/test in parallel
#

NODE_INDEX=${CIRCLE_NODE_INDEX:-0}

set -e

export NODE_ENV=test

if [ "$NODE_INDEX" = "1" ]; then
  echo "Running node $NODE_INDEX ..."

  sudo apt-get -y install cpanminus

  echo "Testing perl"
  (cd samples/client/petstore/perl && /bin/bash ./test.bash)


elif [ "$NODE_INDEX" = "2" ]; then
  echo "Running node $NODE_INDEX to test cpp-restsdk"

  # install cpprestsdk
  sudo apt-get install libcpprest-dev
  wget "https://github.com/aminya/setup-cpp/releases/download/v0.37.0/setup-cpp-x64-linux"
  chmod +x ./setup-cpp-x64-linux
  sudo ./setup-cpp-x64-linux --compiler llvm --cmake true --ninja true
  source ~/.cpprc # activate cpp environment variables



elif [ "$NODE_INDEX" = "3" ]; then

  echo "Running node $NODE_INDEX ... "

  echo "Testing ruby"
  

else
  echo "Running node $NODE_INDEX ..."
  java -version
  ./mvnw clean install

fi
