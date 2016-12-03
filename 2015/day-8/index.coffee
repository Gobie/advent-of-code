fs = require 'fs'
path = require 'path'

diffMemory = diffEncoded = 0
content = fs.readFileSync(path.join __dirname, 'input.txt').toString()
for source in content.split /\n/
  memory = source
  .replace /\\\\/g, -> '_'
  .replace /\\x[0-9a-f]{2}/g, -> '_'
  .replace /\\"/g, -> '_'
  .replace /^"|"$/g, -> ''
  diffMemory += source.length - memory.length

  encoded = source
  .replace /["\\]/g, -> "\\_"
  .replace /^|$/g, -> '"'
  diffEncoded += encoded.length - source.length

console.log 'Part 1', diffMemory
console.log 'Part 2', diffEncoded
