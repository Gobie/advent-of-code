fs = require 'fs'
path = require 'path'

x = 0
y = 0
direction = 'N'
map = ['x0y0']
crossing = null

turnMap =
  'N':
    'R': 'E'
    'L': 'W'
  'E':
    'R': 'S'
    'L': 'N'
  'S':
    'R': 'W'
    'L': 'E'
  'W':
    'R': 'N'
    'L': 'S'

turn = (direction, way) ->
  turnMap[direction][way]

follow = (direction, x, y, distance) ->
  switch direction
    when 'N'
      return [x, y + distance]
    when 'E'
      return [x + distance, y]
    when 'S'
      return [x, y - distance]
    when 'W'
      return [x - distance, y]

record = (map, x, y, newX, newY) ->
  first = yes
  if x isnt newX
    for xi in [x..newX]
      if first
        first = no
        continue
      coords = 'x'+xi+'y'+y
      return coords if coords in map
      map.push coords
  else if y isnt newY
    for yi in [y..newY]
      if first
        first = no
        continue
      coords = 'x'+x+'y'+yi
      return coords if coords in map
      map.push coords
  null

content = fs.readFileSync(path.join __dirname, 'input.txt').toString()
for instruction in content.split ', '
  [_, way, distance] = instruction.match /^([RL])(\d+)$/
  direction = turn direction, way
  [newX, newY] = follow direction, x, y, +distance
  crossing ?= record map, x, y, newX, newY
  [x, y] = [newX, newY]

console.log 'Part 1', Math.abs(x) + Math.abs(y)

[_, x, y] = crossing.match /^x(-?\d+)y(-?\d+)$/
console.log 'Part 2', Math.abs(x) + Math.abs(y)
