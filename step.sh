#!/bin/bash
set -ex

THIS_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $THIS_SCRIPT_DIR

mvn mockserver:runForked 
#config exportations

curl -v -X PUT "http://localhost/mockserver/expectation" -d '{                                              
  "httpRequest" : {                      
    "path" : "/.*"
  },
  "httpResponse" : {
    "body" : "OK"
  }
}'

# envman add --key EXAMPLE_STEP_OUTPUT --value 'the value you want to share'
