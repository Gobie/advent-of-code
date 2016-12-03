fs = require 'fs'
path = require 'path'

position = [1, 1]
codes = []

follow = ([x, y], instruction) ->
  switch instruction
    when 'U'
      return [x, Math.max(y - 1, 0)]
    when 'D'
      return [x, Math.min(y + 1, 2)]
    when 'L'
      return [Math.max(x - 1, 0), y]
    when 'R'
      return [Math.min(x + 1, 2), y]

content = fs.readFileSync(path.join __dirname, 'input.txt').toString()
for sequence in content.split /\n/
  for instruction in sequence.split ''
    position = follow position, instruction

  [x, y] = position
  codes.push x + 1 + 3 * y

console.log 'Part 1', codes.join ''

position = [-2, 0]
codes = []

follow = ([x, y], instruction) ->
  switch instruction
    when 'U'
      return [x, y + 1 - (y >= 0 and Math.abs(x) + Math.abs(y) is 2)]
    when 'D'
      return [x, y - 1 + (y <= 0 and Math.abs(x) + Math.abs(y) is 2)]
    when 'L'
      return [x - 1 + (x <= 0 and Math.abs(x) + Math.abs(y) is 2), y]
    when 'R'
      return [x + 1 - (x >= 0 and Math.abs(x) + Math.abs(y) is 2), y]

content = fs.readFileSync(path.join __dirname, 'input.txt').toString()
for sequence in content.split /\n/
  for instruction in sequence.split ''
    position = follow position, instruction

  [x, y] = position
  code = 7 + x - y * if Math.abs(y) is 2 then 3 else 4
  codes.push code.toString(16).toUpperCase()

console.log 'Part 2', codes.join ''
