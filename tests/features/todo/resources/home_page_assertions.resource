*** Settings ***
Resource    ./home_page_variables.resource
Resource    ../../../shared/resources/collections_utilities.resource
Resource    ../../../shared/resources/auto_wait_assertions.resource


*** Keywords ***
Wait Until Home Page Is Loaded
    [Documentation]    Wait until the home page main element is visible and ready.
    Wait Until Element Is Visible    xpath://h1[.="Todos"]

Todo Item Should Contain Text
    [Documentation]    Assert that at least one todo item contains the given text.
    [Arguments]    ${expected_text}
    Wait Until Element Is Visible    ${TODO_ITEM_LIST}
    ${items} =    Get Texts From Elements    locator=${TODO_ITEM_LIST}
    List Should Contain Value    ${items}    ${expected_text}

Input Should Be Cleared
    [Documentation]    Assert That the new todo input field is empty.
    Wait Until Element Is Visible    ${NEW_TODO_INPUT}
    Wait Until Keyword Succeeds
    ...    5s
    ...    500ms
    ...    Element Attribute Value Should Be
    ...    ${NEW_TODO_INPUT}
    ...    value
    ...    ${EMPTY}

Counter Text Contain Should Contain Todo Count
    [Documentation]    Assert that the counter displays the expected remaining todo count.
    [Arguments]    ${count}
    Wait Until Element Is Visible    ${TODO_COUNT}
    ${text} =    Get Text    ${TODO_COUNT}
    ${expected_suffix} =    Set Variable If    ${count} == 1    item    items
    VAR    ${expected} =    ${count} ${expected_suffix} left
    Should Be Equal    ${text}    ${expected}

Todo Creation Should Be Success
    [Documentation]    Validate that todo creation is successful: item present,
    ...                input cleared, counter updated.
    [Arguments]    ${todo_item_text}    ${count}
    Todo Item Should Contain Text    ${todo_item_text}
    Input Should Be Cleared
    Counter Text Contain Should Contain Todo Count    ${count}

Todo Items Should Be In Order
    [Documentation]    Assert that todo items match expected names in correct order.
    [Arguments]    ${expected_items}
    Wait Until Element Is Visible    ${TODO_ITEM_LIST}
    ${actual} =    Get Texts From Elements    ${TODO_ITEM_LIST}
    Lists Should Be Equal    ${actual}    ${expected_items}

Multiple Todo Creation Should Be Success
    [Documentation]    Validate that multiple todos are created in correct order and counter matches.
    [Arguments]    ${expected_items}
    Todo Items Should Be In Order    ${expected_items}
    ${items_count} =    Get Length    ${expected_items}
    Counter Text Contain Should Contain Todo Count    ${items_count}

Todo Text Should Exactly Be
    [Documentation]    Verifies that the todo item is visible and its text exactly matches the expected value.
    [Arguments]    ${expected}
    VAR    ${locator} =    xpath=//label[text()="${expected}"]
    Wait Until Element Is Visible    ${locator}
    Element Text Should Be    ${locator}    ${expected}

Todo Count Should Be
    [Documentation]    Asserts the number of todo items equals the expected value
    [Arguments]    ${expected}
    ${count} =    Get Element Count    ${TODO_ITEM_LIST}
    Should Be Equal As Integers    ${count}    ${expected}

Todo List Should Be Empty
    [Documentation]    Asserts that the todo list contains no items
    Wait Until Keyword Succeeds
    ...    5s
    ...    500ms
    ...    Todo Count Should Be
    ...    0

Todo Counter Should Be Hidden
    [Documentation]    Asserts that the counter is hidden
    Wait Until Keyword Succeeds
    ...    5s
    ...    500ms
    ...    Element Should Not Be Visible    ${TODO_COUNT}

Element Should Not Be Visible
    [Documentation]    Asserts that the given element is not visible
    [Arguments]    ${locator}
    Run Keyword And Expect Error
    ...    *
    ...    Wait Until Element Is Visible
    ...    ${locator}

No Alert Should Be Visible
    [Documentation]    Asserts that no browser alert is visible.
    Wait Until Keyword Succeeds
    ...    5s
    ...    500ms
    ...    Alert Should Not Exist

Alert Should Not Exist
    [Documentation]    Fails if a browser alert is present.
    Run Keyword And Expect Error
    ...    *
    ...    Handle Alert
    ...    ACCEPT

Edit Input Should Have Value
    [Documentation]    Input Should Have Value
    [Arguments]    ${value}
    Input Should Be Ready    ${LOCATOR_EDIT_TODO_INPUT}
    Wait Until Keyword Succeeds
    ...    5s
    ...    500ms
    ...    Element Attribute Value Should Be
    ...    ${LOCATOR_EDIT_TODO_INPUT}
    ...    value
    ...    ${value}
