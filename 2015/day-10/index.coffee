fs = require 'fs'
path = require 'path'

content = fs.readFileSync(path.join __dirname, 'input.txt').toString()

gameOfLife = (value, count) ->
  for iter in [1..count]
    # elegant but much slower
    # value = value.replace /(.)\1*/g, (_, _1) ->
    #   "#{_.length}#{_1}"
    last = ''
    len = 0
    out = ''
    for c in value
      if c isnt last and last isnt ''
        out += "#{len}#{last}"
        len = 0
      last = c
      len++
    out += "#{len}#{last}"
    value = out
  value

console.log 'Part 1', gameOfLife(content, 40).length
console.log 'Part 2', gameOfLife(content, 50).length
