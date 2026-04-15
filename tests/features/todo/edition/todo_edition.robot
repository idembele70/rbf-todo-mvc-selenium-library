*** Settings ***
Resource            ../resources/home_page.resource

Test Setup          Run Keywords
...                     Open Browser To All Todos Page    AND
...                     Create One Todo    ${DEFAULT_TODO_NAME}
Test Teardown       Close Browser

Test Tags           edit


*** Test Cases ***
Edit A Task With Valid Text
    [Documentation]    Double-click on a task, change its text, and press Enter
    [Tags]    happy
    VAR    ${new_name}    Buy some bread
    Edit One Todo    ${DEFAULT_TODO_NAME}    ${new_name}
    Todo Text Should Exactly Be    ${new_name}

Edit A Task And Verify The Input Is Pre-Filled
    [Documentation]    Verify that the edit input contains the current task title on focus
    [Tags]    happy
    Enter Edit Mode    ${DEFAULT_TODO_NAME}
    Edit Input Should Have Value    ${DEFAULT_TODO_NAME}

Edit A Task With Special Characters
    [Documentation]    Change a task title to a value containing accents and typographic characters
    [Tags]    happy
    VAR    ${new_name}    Reunion a 9h30 — salle B
    Edit One Todo    ${DEFAULT_TODO_NAME}    ${new_name}
    Todo Text Should Exactly Be    ${new_name}

Edit A Task With Digits And Punctuation
    [Documentation]    Change a task title to a value containing numbers and punctuation
    [Tags]    happy
    VAR    ${new_name}    Call +1-800-555-0199
    Edit One Todo    ${DEFAULT_TODO_NAME}    ${new_name}
    Todo Text Should Exactly Be    ${new_name}

Cancel Editing By Clicking Outside
    [Documentation]    Verify that losing focus on the edit field cancels the edit
    [Tags]    happy    fixme
    # This feature is not implemented yet
    Enter Edit Mode    ${DEFAULT_TODO_NAME}
    # Exit Edit Mode By Clicking Outside The Input

Submit An Empty Edit
    [Documentation]    Clear all text in the edit field and press Enter
    [Tags]    error
    Enter Edit Mode    ${DEFAULT_TODO_NAME}
    Clear Edit Input
    Submit Edit
    Todo List Should Be Empty

Submit Whitespace Only In Edit
    [Documentation]    Replace the task text with only spaces and press Enter
    [Tags]    error    fixme
    Edit One Todo    ${DEFAULT_TODO_NAME}    ${SPACE * 3}
    Todo List Should Be Empty

Edit With Very Long Text
    [Documentation]    Replace the task with 300-character string
    [Tags]    edge
    ${new_name}    Evaluate    'a' * 300
    Edit One Todo    ${DEFAULT_TODO_NAME}    ${new_name}
    Todo Text Should Exactly Be    ${new_name}

Edit With A Single Character
    [Documentation]    Replace the task text with a single character
    [Tags]    edge
    VAR    ${new_name}    A
    Edit One Todo    ${DEFAULT_TODO_NAME}    ${new_name}
    Todo Text Should Exactly Be    ${new_name}

Edit Text With Leading And Trailing Spaces
    [Documentation]    Verify whether trim is applied during editing
    [Tags]    edge    fixme
    VAR    ${new_name}    My edited task
    Edit One Todo    ${DEFAULT_TODO_NAME}    ${SPACE*2}${new_name}${SPACE*2}
    Todo Text Should Exactly Be    ${new_name}

Html Injection In Edited Title
    [Documentation]    Replace task title with HTML content
    [Tags]    edge
    VAR    ${new_name}    <script>alert(1)</script>
    Edit One Todo    ${DEFAULT_TODO_NAME}    ${new_name}
    No Alert Should Be Visible
    Todo Text Should Exactly Be    ${new_name}

Edit A Completed Task
    [Documentation]    Verify that a completed task can be edited
    [Tags]    edge
    Mark Todo As Completed    ${DEFAULT_TODO_NAME}
    VAR    ${name}    Buy some bread
    Edit One Todo    ${DEFAULT_TODO_NAME}    ${name}
    Todo Text Should Exactly Be    ${name}

Edit One Task Among Several
    [Documentation]    Edit a specific task without affecting other tasks in the list
    [Tags]    edge
    [Setup]    Run Keywords
    ...    Open Browser To All Todos Page    AND
    ...    Create Multiple Todo    Task A    Task B    Task C
    Edit One Todo    Task B    Task B edited
    VAR    @{tasks}    Task A    Task B edited    Task C
    Todo Items Should Be In Order    ${tasks}

Edit A Task To Duplicate Value
    [Documentation]    Verify that editing a task to match another task's title is allowed
    [Tags]    edge
    [Setup]    Run Keywords
    ...    Open Browser To All Todos Page    AND
    ...    Create Multiple Todo    Task A    Task B
    Edit One Todo    Task B    Task A
    VAR    @{tasks}    Task A    Task A
    Todo Items Should Be In Order    ${tasks}
    Todo Count Should Be    2

Edit A Task While On The "Active" Filter
    [Documentation]    Verify that editing works in the Active view
    [Tags]    edge
    [Setup]    Run Keywords
    ...    Open Browser To Active Todos Page    AND
    ...    Create One Todo    ${DEFAULT_TODO_NAME}
    VAR    ${name}    Buy some bread
    Edit One Todo    ${DEFAULT_TODO_NAME}    ${name}
    Todo Text Should Exactly Be    ${name}

Edit A Task While On The "Completed" Filter
    [Documentation]    verify that editing works in the Completed view
    [Tags]    edge
    Mark Todo As Completed    ${DEFAULT_TODO_NAME}
    Go To Filter View    ${COMPLETED_TODOS_URL}
    VAR    ${name}    Buy some bread
    Edit One Todo    ${DEFAULT_TODO_NAME}    ${name}
    Todo Text Should Exactly Be    ${name}

Persistence Of Edited Task After Page Reload
    [Documentation]    Verify that the edited title presists after a page reload
    [Tags]    edge    fixme
    VAR    ${name}    Buy some bread
    Edit One Todo    ${DEFAULT_TODO_NAME}    ${name}
    Todo Text Should Exactly Be    ${name}
    Reload Page
    Todo Text Should Exactly Be    ${name}
