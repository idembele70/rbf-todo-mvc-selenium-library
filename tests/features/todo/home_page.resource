*** Settings ***
Library     SeleniumLibrary


*** Variables ***
${URL}                  https://todomvc.com/examples/angular/dist/browser/#/all
${BROWSER}              Chrome
${DELAY}                0

${NEW_TODO_INPUT}       xpath://input[@placeholder="What needs to be done?"]


*** Keywords ***
Open Browser To Home Page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Home Page Should Be Open

Home Page Should Be Open
    Title Should Be    TodoMVC: Angular

Fill Todo Name
    [Arguments]    ${todo_name}
    Input Text    ${NEW_TODO_INPUT}    ${todo_name}

Submit Todo
    Press Key    ${NEW_TODO_INPUT}    Enter

Create Todo
    [Arguments]    ${todo_name}
    Fill Todo Name    ${todo_name}
    Submit Todo
