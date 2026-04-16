*** Settings ***
Resource    ./home_page_actions.resource
Resource    ./home_page_assertions.resource


*** Keywords ***
Open Browser To All Todos Page
    [Documentation]    Open browser and navigate to the all todos view.
    Open Browser    ${ALL_TODOS_URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Home Page Is Loaded

Open Browser To Active Todos Page
    [Documentation]    Open browser and navigate to the active todos view.
    Open Browser    ${ACTIVE_TODOS_URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Home Page Is Loaded

Create Multiple Todo
    [Documentation]    Create the specified number of todos
    [Arguments]    @{todo_names}
    FOR    ${name}    IN    @{todo_names}
        Create One Todo    ${name}
    END
    ${count} =    Get Length    ${todo_names}
    Counter Text Contain Should Contain Todo Count    ${count}

Go To Filter View
    [Documentation]    Navigates to the given todo filter view and waits for the home page
    [Arguments]    ${url}
    Go To    ${url}
    Wait Until Home Page Is Loaded

