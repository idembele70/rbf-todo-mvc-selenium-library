*** Settings ***
Library     collections
Library     SeleniumLibrary
Resource    ../../shared/resources/collections_utilities.resource


*** Variables ***
${BASE_URL}                 http://localhost:4200/#/
${ALL_TODOS_URL}            ${BASE_URL}all
${ACTIVE_TODOS_URL}         ${BASE_URL}active
${COMPLETED_TODOS_URL}      ${BASE_URL}completed
${BROWSER}                  headlesschrome

${NEW_TODO_INPUT}           xpath://input[@placeholder="What needs to be done?"]
${TODO_ITEM_LIST}           tag:app-todo-item
${TODO_COUNT}               css:span.todo-count

${ENTER_KEY_UNICODE}        \uE007


*** Keywords ***
Open Browser To All Todos Page
    [Documentation]    Open browser and navigate to the all todos view.
    Open Browser    ${ALL_TODOS_URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Home Page Is Loaded

Wait Until Home Page Is Loaded
    [Documentation]    Wait until the home page main element is visible and ready.
    Wait Until Element Is Visible    xpath://h1[.="Todos"]

Fill Todo Name
    [Documentation]    Fill the new todo input field with the given name.
    [Arguments]    ${todo_name}
    Wait Until Todo Input Is Visible
    Input Text    ${NEW_TODO_INPUT}    ${todo_name}

Submit Todo
    [Documentation]    Submit the new todo by pressing Enter on the input field.
    Wait Until Todo Input Is Visible
    Press Key    ${NEW_TODO_INPUT}    ${ENTER_KEY_UNICODE}

Wait Until Todo Input Is Visible
    [Documentation]    Wait until the new todo input field becomes visible.
    Wait Until Element Is Visible    ${NEW_TODO_INPUT}

Create One Todo
    [Documentation]    Create a new todo by filling the name and submitting it.
    [Arguments]    ${todo_name}
    Fill Todo Name    ${todo_name}
    Submit Todo

Create Multiple Todo
    [Documentation]    Create the specified number of todos
    [Arguments]    @{todo_names}
    FOR    ${name}    IN    @{todo_names}
        Create One Todo    ${name}
    END
    ${count} =    Get Length    ${todo_names}
    Counter Text Contain Should Contain Todo Count    ${count}

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
    Log    ${actual}
    Log    ${expected_items}
    Lists Should Be Equal    ${actual}    ${expected_items}

Multiple Todo Creation Should Be Success
    [Documentation]    Validate that multiple todos are created in correct order and counter matches.
    [Arguments]    ${expected_items}
    Todo Items Should Be In Order    ${expected_items}
    ${items_count} =    Get Length    ${expected_items}
    Log    ${expected_items}
    Log    ${items_count}
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

Go To Filter View
    [Documentation]    Navigates to the given todo filter view and waits for the home page
    [Arguments]    ${url}
    Go To    ${url}
    Wait Until Home Page Is Loaded
