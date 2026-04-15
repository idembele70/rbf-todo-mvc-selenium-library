*** Settings ***
Library     SeleniumLibrary
Resource    ./home_page_variables.resource
Resource    ../../../shared/resources/auto_wait_actions.resource
Resource    ../../../shared/resources/auto_wait_assertions.resource


*** Keywords ***
Fill Todo Name
    [Documentation]    Fill the new todo input field with the given name.
    [Arguments]    ${todo_name}
    Input Should Be Ready    ${NEW_TODO_INPUT}
    Input Text    ${NEW_TODO_INPUT}    ${todo_name}

Submit Todo
    [Documentation]    Submit the new todo by pressing Enter on the input field.
    Input Should Be Ready    ${NEW_TODO_INPUT}
    Press Key    ${NEW_TODO_INPUT}    ${ENTER_KEY_UNICODE}

Create One Todo
    [Documentation]    Create a new todo by filling the name and submitting it.
    [Arguments]    ${todo_name}
    Fill Todo Name    ${todo_name}
    Submit Todo

Get Todo Row Label
    [Documentation]    Return the locator of the todo row label by name.
    [Arguments]    ${name}
    ${row} =    Get WebElement    //label[text()="${name}"]
    Wait Until Element Is Visible    ${row}
    RETURN    ${row}

Enter Edit Mode
    [Documentation]    Enter edit mode by double-clicking the todo row.
    [Arguments]    ${name}
    ${row} =    Get Todo Row Label    ${name}
    Double Click Element    ${row}

Edit One Todo
    [Documentation]    Edit a todo with the given name
    [Arguments]    ${current_name}    ${new_name}
    Enter Edit Mode    ${current_name}
    Input Should Be Ready    ${LOCATOR_EDIT_TODO_INPUT}
    Input Text    ${LOCATOR_EDIT_TODO_INPUT}    ${new_name}
    Submit Edit

Clear Edit Input
    [Documentation]    Auto waits, then clears input.
    Input Should Be Ready    ${LOCATOR_EDIT_TODO_INPUT}
    Press Keys Safely    ${LOCATOR_EDIT_TODO_INPUT}    CTRL+A    DELETE

Submit Edit
    [Documentation]    Auto waits, then submit input value.
    Input Should Be Ready    ${LOCATOR_EDIT_TODO_INPUT}
    Press Key Safely    ${LOCATOR_EDIT_TODO_INPUT}    ${ENTER_KEY_UNICODE}

Get Todo Row Locator By Text
    [Documentation]    Return the app-todo-item containing the given text.
    [Arguments]    ${text}
    VAR    ${locator} =    //app-todo-item[normalize-space(.)="${text}"]
    Wait Until Element Is Visible    ${locator}
    RETURN    ${locator}

Get Todo Row Checkbox
    [Documentation]    Get a todo row checkbox input.
    [Arguments]    ${text}
    ${todo_row} =    Get Todo Row Locator By Text    ${text}
    RETURN    ${todo_row}//input[@type="checkbox"]

Mark Todo As Completed
    [Documentation]    Auto waits, then completed a todo
    [Arguments]    ${text}
    ${checkbox} =    Get Todo Row Checkbox    ${text}
    Select Checkbox    ${checkbox}
