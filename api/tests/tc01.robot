*** Settings ***
Library    RequestsLibrary
Library    Collections


*** Test Cases ***
TC01_Getting_User_Details
    Create Session    origin    https://reqres.in
    ${results}    Get Request    origin    /api/users/2
    Status Should Be    200
    ${Json}    To Json    ${results.content}
    Dictionary Should Contain Key    ${Json}    data
    ${user}    Get From Dictionary    ${json}    data
    Should Be Equal As Integers    ${user['id']}    2
    Should Be Equal As Strings     ${user['email']}    janet.weaver@reqres.in
    Should Be Equal As Strings     ${user['first_name']}    Janet
    Should Be Equal As Strings     ${user['last_name']}     Weaver
    Delete All Sessions
