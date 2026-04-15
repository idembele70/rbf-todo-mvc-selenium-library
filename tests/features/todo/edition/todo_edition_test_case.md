# Test Cases — Feature: Edit a Task (TodoMVC)

## General Information

| Field | Value |
|---|---|
| Application | TodoMVC |
| Feature | Edit a task |
| Trigger | Double-click on a task label to enter edit mode, then modify the text |
| Precondition | The application is open and at least one task exists in the list |

---

## Nominal Cases

### TC-01 — Edit a task with valid text

| Field | Detail |
|---|---|
| **Description** | Double-click on a task, change its text, and press Enter |
| **Precondition** | A task `Buy some milk` exists |
| **Input data** | Double-click on `Buy some milk`, clear, type `Buy some bread` + Enter |
| **Expected result** | The task text is updated to `Buy some bread`. The edit field disappears. The task count is unchanged. |
| **Type** | Nominal |

---

### TC-02 — Edit a task and verify the input is pre-filled

| Field | Detail |
|---|---|
| **Description** | Verify that the edit input contains the current task title on focus |
| **Precondition** | A task `Buy some milk` exists |
| **Input data** | Double-click on `Buy some milk` |
| **Expected result** | The edit input field appears and its value is `Buy some milk`. |
| **Type** | Nominal |

---

### TC-03 — Edit a task with special characters

| Field | Detail |
|---|---|
| **Description** | Change a task title to a value containing accents and typographic characters |
| **Precondition** | A task `Buy some milk` exists |
| **Input data** | Double-click, clear, type `Reunion a 9h30 — salle B` + Enter |
| **Expected result** | The task text is updated to `Reunion a 9h30 — salle B` with no encoding artifacts. |
| **Type** | Nominal |

---

### TC-04 — Edit a task with digits and punctuation

| Field | Detail |
|---|---|
| **Description** | Change a task title to a value containing numbers and punctuation |
| **Precondition** | A task `Buy some milk` exists |
| **Input data** | Double-click, clear, type `Call +1-800-555-0199` + Enter |
| **Expected result** | The task text is updated to `Call +1-800-555-0199`. |
| **Type** | Nominal |

---

### TC-05 — Cancel editing by clicking outside (blur)

| Field | Detail |
|---|---|
| **Description** | Verify that losing focus on the edit field cancels the edit |
| **Precondition** | A task `Buy some milk` exists |
| **Input data** | Double-click on the task, modify the text to `Changed`, then click outside the input |
| **Expected result** | The edit mode is exited. The task text remains `Buy some milk` (unchanged). |
| **Type** | Nominal |

---

## Error Cases

### TC-06 — Submit an empty edit (clear the title and press Enter)

| Field | Detail |
|---|---|
| **Description** | Clear all text in the edit field and press Enter |
| **Precondition** | A task `Buy some milk` exists, counter = `1 item left` |
| **Input data** | Double-click, clear the field entirely, press Enter |
| **Expected result** | The task is removed from the list. The counter is updated accordingly (hidden if no tasks remain). |
| **Type** | Error |

---

### TC-07 — Submit whitespace only in edit

| Field | Detail |
|---|---|
| **Description** | Replace the task text with only spaces and press Enter |
| **Precondition** | A task `Buy some milk` exists |
| **Input data** | Double-click, clear, type `   ` (3 spaces) + Enter |
| **Expected result** | The task should be removed (whitespace-only title is treated as empty). |
| **Type** | Error |

---

## Edge Cases

### TC-08 — Edit with a very long text (255+ characters)

| Field | Detail |
|---|---|
| **Description** | Replace the task text with a 300-character string |
| **Precondition** | A task `Buy some milk` exists |
| **Input data** | Double-click, clear, type a 300-character alphanumeric string + Enter |
| **Expected result** | The task text is updated with no crash or truncation. The display remains readable. |
| **Type** | Edge case |

---

### TC-09 — Edit with a single character

| Field | Detail |
|---|---|
| **Description** | Replace the task text with a single character |
| **Precondition** | A task `Buy some milk` exists |
| **Input data** | Double-click, clear, type `A` + Enter |
| **Expected result** | The task text is updated to `A`. |
| **Type** | Edge case |

---

### TC-10 — Edit text with leading and trailing spaces

| Field | Detail |
|---|---|
| **Description** | Verify whether trim is applied during editing |
| **Precondition** | A task `Buy some milk` exists |
| **Input data** | Double-click, clear, type `  My edited task  ` + Enter |
| **Expected result** | The task is saved. Leading and trailing spaces should be trimmed. Internal spaces are preserved. |
| **Type** | Edge case |

---

### TC-11 — HTML injection in edited title

| Field | Detail |
|---|---|
| **Description** | Replace the task title with HTML content |
| **Precondition** | A task `Buy some milk` exists |
| **Input data** | Double-click, clear, type `<script>alert(1)</script>` + Enter |
| **Expected result** | The text is displayed as-is in the list, not interpreted as HTML. No alert is triggered. |
| **Type** | Edge case |

---

### TC-12 — Edit a completed task

| Field | Detail |
|---|---|
| **Description** | Verify that a completed task can be edited |
| **Precondition** | A task `Buy some milk` exists and is marked as completed |
| **Input data** | Double-click on the completed task, clear, type `Buy some bread` + Enter |
| **Expected result** | The task text is updated to `Buy some bread`. The task remains in "completed" state. |
| **Type** | Edge case |

---

### TC-13 — Edit one task among several

| Field | Detail |
|---|---|
| **Description** | Edit a specific task without affecting other tasks in the list |
| **Precondition** | Three tasks exist: `Task A`, `Task B`, `Task C` |
| **Input data** | Double-click on `Task B`, clear, type `Task B edited` + Enter |
| **Expected result** | Only `Task B` is changed to `Task B edited`. `Task A` and `Task C` remain unchanged. Counter is unchanged. |
| **Type** | Edge case |

---

### TC-14 — Edit a task to a duplicate value

| Field | Detail |
|---|---|
| **Description** | Verify that editing a task to match another task's title is allowed |
| **Precondition** | Two tasks exist: `Task A` and `Task B` |
| **Input data** | Double-click on `Task B`, clear, type `Task A` + Enter |
| **Expected result** | Both tasks now display `Task A`. No deduplication or error occurs. Counter is unchanged. |
| **Type** | Edge case |

---

### TC-15 — Edit a task while on the "Active" filter

| Field | Detail |
|---|---|
| **Description** | Verify that editing works in the Active view |
| **Precondition** | Navigate to `/#/active`, an active task `Buy some milk` exists |
| **Input data** | Double-click on the task, clear, type `Buy some bread` + Enter |
| **Expected result** | The task text is updated to `Buy some bread`. The task remains visible in the Active view. |
| **Type** | Edge case |

---

### TC-16 — Edit a task while on the "Completed" filter

| Field | Detail |
|---|---|
| **Description** | Verify that editing works in the Completed view |
| **Precondition** | Navigate to `/#/completed`, a completed task `Buy some milk` exists |
| **Input data** | Double-click on the task, clear, type `Buy some bread` + Enter |
| **Expected result** | The task text is updated to `Buy some bread`. The task remains visible in the Completed view. |
| **Type** | Edge case |

---

### TC-17 — Persistence of edited task after page reload

| Field | Detail |
|---|---|
| **Description** | Verify that the edited title persists after a page reload |
| **Precondition** | A task `Buy some milk` exists |
| **Input data** | Double-click, clear, type `Buy some bread` + Enter, then reload the page (F5) |
| **Expected result** | The task still displays `Buy some bread` after the reload. |
| **Type** | Edge case |

---

## Summary

| Type | Count |
|---|---|
| Nominal | 5 |
| Error | 2 |
| Edge case | 10 |
| **Total** | **17** |
