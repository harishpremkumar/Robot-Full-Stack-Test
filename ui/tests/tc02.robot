*** Settings ***
Documentation       suite2

Library             SeleniumLibrary


*** Variables ***
${URL}      https://www.saucedemo.com/v1/


*** Test Cases ***
CHROME_OPTIONS_Tc02
    [Documentation]    test2
    ${options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys,selenium.webdriver
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-gpu
    Call Method    ${options}    add_argument    --incognito
    Call Method    ${options}    add_argument    --headless
    Open Browser    ${URL}    chrome    options=${options}
    Sleep    3s
    Maximize Browser Window
    Close Browser
