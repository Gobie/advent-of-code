fs = require 'fs'
path = require 'path'

content = fs.readFileSync(path.join __dirname, 'input.txt').toString()
limit = +content

indexLimit = Math.round limit/40 # optimalizace
housesPart1 = new Array indexLimit
housesPart2 = new Array indexLimit
for i in [1..indexLimit] by 1
  for j in [i..indexLimit] by i
    housesPart1[j] ?= 0
    housesPart1[j] += i * 10

    if j / i <= 50
      housesPart2[j] ?= 0
      housesPart2[j] += i * 11

findIndex = (houses, limit) ->
  for value, index in houses when value >= limit
    return index
  -1

console.log 'Part 1', findIndex housesPart1, limit
console.log 'Part 2', findIndex housesPart2, limit
