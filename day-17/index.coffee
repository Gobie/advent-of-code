fs = require 'fs'
path = require 'path'

content = fs.readFileSync(path.join __dirname, 'input.txt').toString()
containers = content.split(/\n/).map (container) -> +container
numContainers = containers.length

accumulate = (liters, startIndex, acc, count) ->
  if liters is 0
    acc.push count
    return
  for i in [startIndex...numContainers] by 1 when (remaining = liters - containers[i]) >= 0
    accumulate remaining, i + 1, acc, count + 1
  return

accumulate 150, 0, acc = [], 0
console.log 'Part 1', acc.length

sorted = acc.sort (a, b) -> a - b
console.log 'Part 2', sorted.lastIndexOf(sorted[0]) + 1
