*** Settings ***
Library     SeleniumLibrary

*** Variables ***
${DEFAULT_TIMEOUT}          5s
${DEFAULT_RETRY_DELAY}      500ms


*** Keywords ***
Double Click Safely
    [Documentation]    ...
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}
    Wait Until Element Is Enabled    ${locator}
    Double Click Element    ${locator}

Clear Input Safely
    [Documentation]    ...
    [Arguments]    ${locator}
    Wait Until Keyword Succeeds
    ...    ${DEFAULT_TIMEOUT}
    ...    ${DEFAULT_RETRY_DELAY}
    ...    Clear Element Text
    ...    ${locator}

Press Key Safely
    [Documentation]    ...
    [Arguments]    ${locator}    ${key}
    Wait Until Keyword Succeeds
    ...    ${DEFAULT_TIMEOUT}
    ...    ${DEFAULT_RETRY_DELAY}
    ...    Press Key
    ...    ${locator}
    ...    ${key}

Press Keys Safely
    [Documentation]    ...
    [Arguments]    ${locator}    @{keys}
    Wait Until Keyword Succeeds
    ...    ${DEFAULT_TIMEOUT}
    ...    ${DEFAULT_RETRY_DELAY}
    ...    Press Keys
    ...    ${locator}
    ...    @{keys}
