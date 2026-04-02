*** Settings ***
Library    SeleniumLibrary

Resource    ../home_page.resource

Suite Setup    Open Browser To Home Page

*** Test Cases ***

Create a valid task
    [Tags]    @happy
    Create Todo    todo_name=first todo

Create multiple tasks in a row

Task with special characters

Task with digits and punctuation

Input field cleared after submission

Submit an empty field

Submit whitespace only

Submit tabs only

Very long task (255+ characters)

Task with a single character

Text with leading and trailing spaces

HTML injection in the task title

Duplicate task created twice

Create a task while on the "Active" filter

Create a task while on the "Completed" filter

Persistence after page reload
