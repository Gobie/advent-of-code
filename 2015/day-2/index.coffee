fs = require 'fs'
path = require 'path'

totalArea = totalRibbon = 0
content = fs.readFileSync(path.join __dirname, 'input.txt').toString()
for size in content.split /\n/
  size.replace /^(\d+)x(\d+)x(\d+)$/, (_, l, w, h) ->
    totalArea += 2*l*w + 2*w*h + 2*h*l + Math.min l*w, w*h, h*l
    totalRibbon += 2*l + 2*w + 2*h - 2*Math.max(l, w, h) + l*w*h

console.log 'Part 1', totalArea
console.log 'Part 2', totalRibbon
