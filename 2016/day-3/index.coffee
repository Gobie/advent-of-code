fs = require 'fs'
path = require 'path'

isTriangle = (numbers) ->
  numbers[0] + numbers[1] + numbers[2] > 2 * Math.max.apply null, numbers

content = fs.readFileSync(path.join __dirname, 'input.txt').toString()
matrix = for rows in content.split /\n/
  rows.trim().split(/\s+/).map Number

pocet = 0
for numbers in matrix
  pocet += isTriangle numbers

console.log 'Part 1', pocet

transposedMatrix = matrix[0].map (col, index) ->
  matrix.map (row) ->
    row[index]

pocet = 0
for row in transposedMatrix
  while (numbers = row.splice(0, 3)).length
    pocet += isTriangle numbers

console.log 'Part 2', pocet