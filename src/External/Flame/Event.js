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

// No any checks because it is called
// only from "keydown" handlers.
export function key_(event) {
  return event.key;
}

// No any checks because it is called
// only from "keydown" handlers.
export function keyCode_(event) {
  return event.keyCode;
}
