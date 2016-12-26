fs = require 'fs'
path = require 'path'

COLUMNS = 50
ROWS = 6

createMatrix = (m, n) ->
  matrix = []
  for i in [0...m]
    matrix[i] ?= []
    for j in [0...n]
      matrix[i][j] = 0
  matrix

createRectangle = (matrix, m, n) ->
  for i in [0...m % ROWS]
    for j in [0...n % COLUMNS]
      matrix[i][j] = 1

rotateRight = (matrix, rowIndex, shift) ->
  row = []
  matrix[rowIndex].forEach (v, i) ->
    row[(i + shift) % COLUMNS] = v
  matrix[rowIndex] = row

rotateDown = (matrix, colIndex, shift) ->
  col = []
  for row, rowIndex in matrix
    col[(rowIndex + shift) % ROWS] = row[colIndex]
  for row, rowIndex in matrix
    row[colIndex] = col[rowIndex]

matrix = createMatrix ROWS, COLUMNS
content = fs.readFileSync(path.join __dirname, 'input.txt').toString()
for instruction in content.split '\n'
  if matches = instruction.match /^rect (\d+)x(\d+)$/
    createRectangle matrix, +matches[2], +matches[1]
  else if matches = instruction.match /^rotate row y=(\d+) by (\d+)$/
    rotateRight matrix, +matches[1], +matches[2]
  else if matches = instruction.match /^rotate column x=(\d+) by (\d+)$/
    rotateDown matrix, +matches[1], +matches[2]

total = 0
for r in matrix
  for v in r
    total += v

console.log 'Part 1', total

console.log 'Part 2'
for r in matrix
  console.log r.join(' ')
