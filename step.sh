#!/bin/bash
set -ex

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
