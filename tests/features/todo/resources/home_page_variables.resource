*** Variables ***
${BASE_URL}                     http://localhost:4200/#/
${ALL_TODOS_URL}                ${BASE_URL}all
${ACTIVE_TODOS_URL}             ${BASE_URL}active
${COMPLETED_TODOS_URL}          ${BASE_URL}completed
# ${BROWSER}    headlesschrome
${BROWSER}                      Chrome

${NEW_TODO_INPUT}               xpath://input[@placeholder="What needs to be done?"]
${TODO_ITEM_LIST}               tag:app-todo-item
${TODO_COUNT}                   css:span.todo-count
${LOCATOR_EDIT_TODO_INPUT}      id:edit-todo-input

${ENTER_KEY_UNICODE}            \uE007

${DEFAULT_TODO_NAME}            Buy some milk
