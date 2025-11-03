#!/usr/bin/env bash
set -euo pipefail

TASKS_OUT="${1:-tasks.out}"  
TESTS_OUT="${2:-tests.out}"   
HTML_FILE="index.html"

if [[ ! -f "$HTML_FILE" ]]; then
  cat > "$HTML_FILE" <<'HTML'
<!doctype html>
<html>
  <head><meta charset="utf-8"><title>Task Manager</title></head>
  <body>
    <h1>Task Manager</h1>
    <h2>ToDo</h2>
    <pre id="todo"></pre>
    <h2>Done</h2>
    <pre id="done"></pre>
    <h2>Unit Tests</h2>
    <pre id="tests"></pre>
  </body>
</html>
HTML
fi

TODO_BLOCK="$(awk '/^ToDo Tasks:/{flag=1;next}/^Done Tasks:/{flag=0}flag' "$TASKS_OUT" || true)"
DONE_BLOCK="$(awk '/^Done Tasks:/{flag=1;next}flag' "$TASKS_OUT" || true)"
TEST_BLOCK="$(cat "$TESTS_OUT" || true)"

update_pre () {
  local pre_id="$1"
  local content="$2"
  local file="$3"
  perl -0777 -i -pe "s|(<pre id=\"$pre_id\">)[\\s\\S]*?(</pre>)|\$1\n$content\n\$2|g" "$file"
}

update_pre "todo"  "${TODO_BLOCK}" "$HTML_FILE"
update_pre "done"  "${DONE_BLOCK}" "$HTML_FILE"
update_pre "tests" "${TEST_BLOCK}" "$HTML_FILE"

git config --global user.name  "github-actions[bot]"
git config --global user.email "github-actions[bot]@users.noreply.github.com"
git add "$HTML_FILE"
git commit -m "Update index.html with tasks & tests" || echo "No HTML changes"
