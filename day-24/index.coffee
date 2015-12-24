fs = require 'fs'
path = require 'path'

createWorld = ->
  content = fs.readFileSync(path.join __dirname, 'input.txt').toString()
  (+command for command in content.split /\n/)

sum = (items) ->
  total = 0
  total += item for item in items
  total

minQE = (arr, maxSum) ->
  minQe = Infinity
  len = arr.length
  subsets = (arr, index, qe, sum) ->
    return no if sum > maxSum
    if sum is maxSum
      minQe = qe if minQe > qe
      return no

    for i in [index...len] by 1
      break unless subsets arr, i + 1, qe * arr[i], sum + arr[i]
    return yes
  subsets arr, 0, 1, 0
  minQe

world = createWorld()

console.log 'Part 1', minQE world, sum(world)/3
console.log 'Part 2', minQE world, sum(world)/4
