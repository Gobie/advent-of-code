fs = require 'fs'
path = require 'path'

counter = 0
foundIndex = null

content = fs.readFileSync(path.join __dirname, 'input.txt').toString()
for direction, index in content
  counter += if direction is '(' then 1 else -1
  foundIndex ?= index + 1 if counter < 0

console.log 'Part 1', counter
console.log 'Part 2', foundIndex
