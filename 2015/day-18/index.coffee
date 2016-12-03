fs = require 'fs'
path = require 'path'

steps = 100

createState = ->
  state = []
  content = fs.readFileSync(path.join __dirname, 'input.txt').toString()
  for command, x in content.split /\n/
    y = 0
    state[x] = []
    command.replace /./g, (char) ->
      state[x][y++] = char is '#'
  state

getNeighborsOn = (state, x, y) ->
  (state[x+1]?[y+1] ? 0) + (state[x+1]?[y] ? 0) + (state[x+1]?[y-1] ? 0) +
  (state[x][y+1] ? 0) + (state[x][y-1] ? 0) +
  (state[x-1]?[y+1] ? 0) + (state[x-1]?[y] ? 0) + (state[x-1]?[y-1] ? 0)

animate = (state) ->
  state.map (row, x) ->
    row.map (value, y) ->
      neighborsOn = getNeighborsOn state, x, y
      return neighborsOn in [2, 3] if value
      return neighborsOn is 3

countLights = (state) ->
  size = state.length - 1
  count = 0
  for x in [0..size] by 1
    for y in [0..size] by 1
      count += state[x][y]
  count

cornernsAlwaysOn = (state) ->
  size = state.length - 1
  state[0][0] = state[0][size] = state[size][0] = state[size][size] = yes
  state

state = createState()
for i in [1..steps] by 1
  state = animate state

console.log 'Part 1', countLights state

state = createState()
cornernsAlwaysOn state
for i in [1..steps] by 1
  state = animate state
  state = cornernsAlwaysOn state

console.log 'Part 2', countLights state
