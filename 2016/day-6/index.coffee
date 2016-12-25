fs = require 'fs'
path = require 'path'
crypto = require 'crypto'

getMatrix = (content) ->
  rows = content.split /\n/
  for row in rows
    row.split ''

transpose = (matrix) ->
  matrix[0].map (col, index) ->
    matrix.map (row) ->
      row[index]

getFrequencyMap = (string) ->
  map = {}
  for letter in string
    map[letter] ?= 0
    map[letter]++
  map

getMostUsedCharacter = (row) ->
  ({letter, count} for letter, count of getFrequencyMap row)
    .sort (a, b) -> (b.count - a.count) || a.letter.localeCompare(b.letter)
    .slice 0, 1
    .map (freq) -> freq.letter
    .join ''

getLeastUsedCharacter = (row) ->
  ({letter, count} for letter, count of getFrequencyMap row)
    .sort (a, b) -> (a.count - b.count) || a.letter.localeCompare(b.letter)
    .slice 0, 1
    .map (freq) -> freq.letter
    .join ''

content = fs.readFileSync(path.join __dirname, 'input.txt').toString()
matrix = getMatrix content
transposeMatrix = transpose matrix
letters = for row in transposeMatrix
  getMostUsedCharacter row

console.log 'Part 1', letters.join ''

letters = for row in transposeMatrix
  getLeastUsedCharacter row

console.log 'Part 2', letters.join ''