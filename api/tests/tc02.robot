*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem


*** Test Cases ***
TC02_Creating_User_Details
    ${auth}    Create Dictionary    x-api-key=${api_key}   Content-Type=application/json
    ${payload_json}    Create Dictionary    name=morpheus    job=leader
    ${json}=    evaluate    json.dumps(${payload_json})      json
    Create Session    origin    https://reqres.in    headers=${auth}
    ${results}    Post Request    origin    /api/users    data=${json}     
    Status Should Be    201
    ${response_dict}    To JSON    ${results.content}

     FOR    ${key}    IN    @{payload_json.keys()}
        ${expected}    Get From Dictionary    ${payload_json}    ${key}
        ${actual}      Get From Dictionary    ${response_dict}    ${key}
        Should Be Equal As Strings    ${actual}    ${expected}
    END
    Delete All Sessions