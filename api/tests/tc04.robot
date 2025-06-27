*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem


*** Test Cases ***
TC04_Deleting_User_Details
    ${auth}    Create Dictionary    x-api-key=${api_key}    Content-Type=application/json
    Create Session    origin    https://reqres.in    headers=${auth}
    ${results}    Delete Request    origin    /api/users/2
    Status Should Be    204
    Delete All Sessions
    