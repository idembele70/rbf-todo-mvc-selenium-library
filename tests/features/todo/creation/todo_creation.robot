*** Settings ***
Library             SeleniumLibrary
Resource            ../home_page.resource

Test Setup         Open Browser To All Todos Page
Test Teardown       Close Browser


*** Test Cases ***
Create A Valid Task
    [Documentation]    Create a task with standard text
    [Tags]    happy    smoke
    VAR    ${todo_name}    Buy some milk
    Create One Todo    todo_name=${todo_name}
    Todo Creation Should Be Success    ${todo_name}    count=1

Create Multiple Tasks In A Row
    [Documentation]    Create several todos and verify correct order and counter.
    [Tags]    happy
    VAR    @{todo_names}    Do homework    Clean house    Learn RBF
    Create Multiple Todo    @{todo_names}
    Multiple Todo Creation Should Be Success    ${todo_names}

Task With Special Characters
    [Documentation]    Verify support for accents and typographic characters
    [Tags]    happy
    VAR    ${todo_name}    Meeting at 9:30 — room B
    Create One Todo    ${todo_name}
    Todo Text Should Exactly Be    ${todo_name}

Task With Digits And Punctuation
    [Documentation]    Verify that numbers and punctuation are accepted
    [Tags]    happy
    VAR    ${todo_name}    Call +1-800-555-0199
    Create One Todo    ${todo_name}
    Todo Text Should Exactly Be    ${todo_name}

Input Field Cleared After Submission
    [Documentation]    Verify the field behavior after a task is submitted
    [Tags]    happy
    Create One Todo    Valid Todo
    Input Should Be Cleared

Submit An Empty Field
    [Documentation]    Press Enter without typing anything
    [Tags]    negative
    Create One Todo    ${EMPTY}
    Todo List Should Be Empty
    Todo Counter Should Be Hidden

Submit Whitespace Only
    [Documentation]    Verify that input is trimmed before validation
    [Tags]    negative    fixme
    # It's possible to create a todo with empty space...
    VAR    ${todo_name}    ${SPACE}${SPACE}${SPACE}
    Create One Todo    ${todo_name}

Submit Tabs Only
    [Documentation]    Verify that non-space invisible characters are also rejected
    [Tags]    negative
    ${todo_name} =    Evaluate    "\t\t"
    Create One Todo    ${todo_name}
    Todo List Should Be Empty
    Todo Counter Should Be Hidden

Very Long Task (255+ Characters)
    [Documentation]    Verify behavior with a string exceeding typical length limits
    [Tags]    edge
    ${todo_name} =    Evaluate    'a' * 300
    Create One Todo    ${todo_name}
    Todo Creation Should Be Success    ${todo_name}    1

Task With A Single Character
    [Documentation]    Verify that the minimun valid length is 1 character
    [Tags]    edge
    VAR    ${todo_name}    A
    Create One Todo    ${todo_name}
    Todo Creation Should Be Success    ${todo_name}    1

Text With Leading And Trailing Spaces
    [Documentation]    Verify that trim is applied without removing internal spaces
    [Tags]    edge    fixme
    # The leading and ending space are not trimmed.
    VAR    ${todo_name}    '  My task  '
    Create One Todo    ${todo_name}

Html Injection In The Task Title
    [Documentation]    Verify that HTML content is displayed as plain text
    [Tags]    edge
    VAR    ${name}    <script>alert(1)</script>
    Create One Todo    ${name}
    Todo Creation Should Be Success    ${name}    1
    No Alert Should Be Visible

Duplicate Task Created Twice
    [Documentation]    Verify there is no automatic deduplication
    [Tags]    edge
    VAR    @{names} =    Clean the house    Clean the house
    Create Multiple Todo    @{names}
    Todo Count Should Be    2

Create A Task While On The "Active" Filter
    [Documentation]    Verify that a new task is visible in the Active view
    [Tags]    edge
    Go To Filter View    ${ACTIVE_TODOS_URL}
    VAR    ${name}    active todo
    Create One Todo    ${name}
    Todo Creation Should Be Success    ${name}    1

Create A Task While On The "Completed" Filter
    [Documentation]    Verify that a new task does not appear in the Completed view
    [Tags]    edge
    Go To Filter View    ${COMPLETED_TODOS_URL}
    Create One Todo    not visible todo
    Todo Count Should Be    0

Persistence After Page Reload
    [Documentation]    Verify that tasks are saved in localStorage
    [Tags]    edge    fixme
    # localStorage persistence is not implemented yet.
    Create One Todo    'persistent todo'
    Todo Count Should Be    1
    Reload Page
    Todo Count Should Be    1
