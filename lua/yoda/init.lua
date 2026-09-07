local M = {}

local reference = require("yoda.reference")

-- Reference browsing
M.apis = reference.apis
M.todos = reference.todos
M.runs = reference.runs
M.notes = reference.notes

-- Reference creation
M.new_todo = reference.new_todo
M.new_run = reference.new_run
M.new_note = reference.new_note

return M
