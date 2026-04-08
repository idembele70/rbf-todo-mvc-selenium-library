# Test Cases — Feature: Create a Task (TodoMVC)

## General Information

| Field | Value |
|---|---|
| Application | TodoMVC |
| Feature | Create a task |
| Trigger | Type in the main input field + press Enter |
| Precondition | The application is open and the input field is visible |

---

## Nominal Cases

### TC-01 — Create a valid task

| Field | Detail |
|---|---|
| **Description** | Create a task with standard text |
| **Input data** | Type `Buy some milk` + Enter |
| **Expected result** | The task appears in the list. The input field is cleared. The counter displays `1 item left`. |
| **Type** | Nominal |

---

### TC-02 — Create multiple tasks in a row

| Field | Detail |
|---|---|
| **Description** | Submit several tasks one after another |
| **Input data** | Type 3 different tasks successively |
| **Expected result** | All 3 tasks are added in the order they were entered. Counter = `3 items left`. |
| **Type** | Nominal |

---

### TC-03 — Task with special characters

| Field | Detail |
|---|---|
| **Description** | Verify support for accents and typographic characters |
| **Input data** | `Meeting at 9:30 — room B` + Enter |
| **Expected result** | The task is displayed as-is, with no visible encoding (e.g. no `&amp;`). |
| **Type** | Nominal |

---

### TC-04 — Task with digits and punctuation

| Field | Detail |
|---|---|
| **Description** | Verify that numbers and punctuation are accepted |
| **Input data** | `Call +1-800-555-0199` + Enter |
| **Expected result** | The task is displayed correctly. |
| **Type** | Nominal |

---

### TC-05 — Input field cleared after submission

| Field | Detail |
|---|---|
| **Description** | Verify the field behavior after a task is submitted |
| **Input data** | Type any text + Enter |
| **Expected result** | The input field is empty and has focus, ready for the next entry. |
| **Type** | Nominal |

---

## Error Cases

### TC-06 — Submit an empty field

| Field | Detail |
|---|---|
| **Description** | Press Enter without typing anything |
| **Input data** | *(empty field)* + Enter |
| **Expected result** | No task is created. The list and counter remain unchanged. |
| **Type** | Error |

---

### TC-07 — Submit whitespace only

| Field | Detail |
|---|---|
| **Description** | Verify that input is trimmed before validation |
| **Input data** | `   ` (3 spaces) + Enter |
| **Expected result** | No task is created. The trimmed content is empty, so the submission is ignored. |
| **Type** | Error |

---

### TC-08 — Submit tabs only

| Field | Detail |
|---|---|
| **Description** | Verify that non-space invisible characters are also rejected |
| **Input data** | `\t\t` (tab characters) + Enter |
| **Expected result** | No task is created. |
| **Type** | Error |

---

## Edge Cases

### TC-09 — Very long task (255+ characters)

| Field | Detail |
|---|---|
| **Description** | Verify behavior with a string exceeding typical length limits |
| **Input data** | A 300-character alphanumeric string + Enter |
| **Expected result** | The task is created with no crash and no silent truncation. The display remains readable. |
| **Type** | Edge case |

---

### TC-10 — Task with a single character

| Field | Detail |
|---|---|
| **Description** | Verify that the minimum valid length is 1 character |
| **Input data** | `A` + Enter |
| **Expected result** | The task is created. A single character is a valid value. |
| **Type** | Edge case |

---

### TC-11 — Text with leading and trailing spaces

| Field | Detail |
|---|---|
| **Description** | Verify that trim is applied without removing internal spaces |
| **Input data** | `  My task  ` + Enter |
| **Expected result** | The task is saved and displayed without the surrounding spaces. Internal spaces are preserved. |
| **Type** | Edge case |

---

### TC-12 — HTML injection in the task title

| Field | Detail |
|---|---|
| **Description** | Verify that HTML content is displayed as plain text |
| **Input data** | `<script>alert(1)</script>` + Enter |
| **Expected result** | The text is displayed as-is in the list, not interpreted as HTML. No alert is triggered. |
| **Type** | Edge case |

---

### TC-13 — Duplicate task created twice

| Field | Detail |
|---|---|
| **Description** | Verify there is no automatic deduplication |
| **Input data** | Create the task `Clean the house` twice |
| **Expected result** | Both tasks coexist in the list. Counter = `2 items left`. |
| **Type** | Edge case |

---

### TC-14 — Create a task while on the "Active" filter

| Field | Detail |
|---|---|
| **Description** | Verify that a new task is visible in the Active view |
| **Precondition** | Navigate to `/#/active` |
| **Input data** | Type a task + Enter |
| **Expected result** | The task appears in the current view (a new task is active by default). |
| **Type** | Edge case |

---

### TC-15 — Create a task while on the "Completed" filter

| Field | Detail |
|---|---|
| **Description** | verify that a new task does not appear in the Completed view |
| **Precondition** | Navigate to `/#/completed` |
| **Input data** | Type a task + Enter |
| **Expected result** | The task does not appear in the current view (it is not completed). It is present on `/#/`. |
| **Type** | Edge case |

---

### TC-16 — Persistence after page reload

| Field | Detail |
|---|---|
| **Description** | Verify that tasks are saved in localStorage |
| **Input data** | Create a task, then reload the page (F5) |
| **Expected result** | The task is still present after the reload. The counter is correct. |
| **Type** | Edge case |

---

## Summary

| Type | Count |
|---|---|
| Nominal | 5 |
| Error | 3 |
| Edge case | 8 |
| **Total** | **16** |