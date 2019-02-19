#!/bin/bash
set -ex

THIS_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $THIS_SCRIPT_DIR
#curl -v "http://localhost"
sudo mvn -q mockserver:runForked
#config exportations
attempt_counter=0
max_attempts=5

until $(curl --output /dev/null --silent --head --fail -X PUT "http://localhost/mockserver/status"); do
    if [ ${attempt_counter} -eq ${max_attempts} ];then
      echo "Max attempts reached"
      exit 42
    fi

    attempt_counter=$(($attempt_counter+1))
    sleep 5
done

curl -v -X PUT "http://localhost/mockserver/expectation" -d '{                                              
  "httpRequest" : {                      
    "path" : "/.*"
  },
  "httpResponse" : {
    "body" : "OK"
  }
}'

# envman add --key EXAMPLE_STEP_OUTPUT --value 'the value you want to share'
