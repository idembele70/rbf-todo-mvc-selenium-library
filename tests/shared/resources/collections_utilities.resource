*** Settings ***
Library     Collections
Library     SeleniumLibrary


*** Keywords ***
Get Texts From Elements
    [Documentation]    Return a list of texts from all elements matching the locator.
    [Arguments]    ${locator}
    ${elements} =    Get WebElements    ${locator}
    ${texts} =    Create List
    FOR    ${el}    IN    @{elements}
        ${t} =    Get Text    ${el}
        Append To List    ${texts}    ${t}
    END
    RETURN    ${texts}
