fs = require 'fs'
path = require 'path'

content = fs.readFileSync(path.join __dirname, 'input.txt').toString()

traverse = (root, ignoreRed) ->
  values = []
  if Array.isArray root
    for val in root
      values = values.concat traverse val, ignoreRed
  else if typeof root is 'object'
    for _, val of root
      return [] if ignoreRed and val is 'red'
      values = values.concat traverse val, ignoreRed
  else if typeof root is 'number'
    values = values.concat root
  values

countTotal = (ignoreRed) ->
  total = 0
  total += value for value in traverse JSON.parse(content), ignoreRed
  total

console.log 'Part 1', countTotal no
console.log 'Part 2', countTotal yes
