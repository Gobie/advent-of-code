fs = require 'fs'
path = require 'path'

createWorld = ->
  world = {}
  content = fs.readFileSync(path.join __dirname, 'input.txt').toString()
  for command in content.split /\n/
    command.replace /^.+row (\d+), column (\d+)\.$/, (_, row, column) ->
      world = {row: +row, column: +column}
  world

sum = (from, to) ->
  to*(to+1)/2 - from*(from-1)/2

getCount = (row, column) ->
  sum(1, column) + sum(column, column - 1 + row - 1)

getValue = (row, column) ->
  count = getCount row, column

  code = 20151125
  for i in [2..count] by 1
    code = (code * 252533) % 33554393
  code

world = createWorld()
console.log 'Part 1', getValue world.row, world.column
