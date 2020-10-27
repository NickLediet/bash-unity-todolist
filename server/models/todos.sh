#!/usr/bin/env sh
function __authenticated_query() {

}

function todo__get_by_id() {
  local id = $1
  local todos = $(__authenticated_query "SELECT * FROM todos WHERE id=$id")
}
