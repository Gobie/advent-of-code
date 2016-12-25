fs = require 'fs'
path = require 'path'

createRoom = (input) ->
  parts = input.split /-/
  [_, id, checksum] = parts.pop().match /(\d+)\[(\w+)\]/
  {id: +id, checksum, name: parts.join ''}

getFrequencyMap = (name) ->
  map = {}
  for letter in name
    map[letter] ?= 0
    map[letter]++
  map

getCheckSum = (name) ->
  ({letter, count} for letter, count of getFrequencyMap name)
    .sort (a, b) -> (b.count - a.count) || a.letter.localeCompare(b.letter)
    .slice 0, 5
    .map (freq) -> freq.letter
    .join ''

isRealRoom = (room) ->
  room.checksum is getCheckSum room.name

content = fs.readFileSync(path.join __dirname, 'input.txt').toString()
rooms = (createRoom row for row in content.split /\n/)

total = 0
for room in rooms when isRealRoom room
  total += room.id

console.log 'Part 1', total

baseA = 'a'.charCodeAt 0
shiftLetter = (letter, n) ->
  (letter.charCodeAt(0) - baseA + n) % 26 + baseA

decryptCaesarCipher = (string, n) ->
  String.fromCharCode.apply null, (shiftLetter letter, n for letter in string)

decrypt = (room) ->
  decryptCaesarCipher room.name, room.id

for room in rooms when isRealRoom room
  if /NorthPole/i.test decrypt room
    console.log 'Part 2', room.id
