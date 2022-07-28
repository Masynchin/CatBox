export function selectionStart_(event) {
  if (
    (event.target.tagName === "INPUT" && event.target.type == "text") ||
    event.target.tagName === "TEXTAREA"
  )
    return event.target.selectionStart;
  return -1;
}

export function selectionEnd_(event) {
  if (
    (event.target.tagName === "INPUT" && event.target.type == "text") ||
    event.target.tagName === "TEXTAREA"
  )
    return event.target.selectionEnd;
  return -1;
}
