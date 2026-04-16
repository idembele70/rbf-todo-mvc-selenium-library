*** Settings ***
Library     SeleniumLibrary


*** Keywords ***
Input Should Be Ready
    [Documentation]    Wait until the input identified by ${locator} becomes visible and enabled.
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}
    Wait Until Element Is Enabled    ${locator}
