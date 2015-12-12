fs = require 'fs'
path = require 'path'

actionsPart1 =
  'turn on': (value) -> 1
  'turn off': (value) -> 0
  'toggle': (value) -> +not value

actionsPart2 =
  'turn on': (value) -> (value or 0) + 1
  'turn off': (value) -> Math.max (value or 0) - 1, 0
  'toggle': (value) -> (value or 0) + 2

content = fs.readFileSync(path.join __dirname, 'input.txt').toString()

countLitBulbs = (actions) ->
  state = {}

  for command in content.split /\n/
    command.replace /^(.+?) (\d+),(\d+) through (\d+),(\d+)$/, (_, action, x0, y0, x1, y1) ->
      for x in [+x0..+x1]
        for y in [+y0..+y1]
          key = "x#{x}y#{y}"
          state[key] = actions[action] state[key]

  total = 0
  total += value for _, value of state
  total

console.log 'Part 1', countLitBulbs actionsPart1
console.log 'Part 2', countLitBulbs actionsPart2
