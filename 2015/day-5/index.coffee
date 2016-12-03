fs = require 'fs'
path = require 'path'

totalPart1 = totalPart2 = 0
content = fs.readFileSync(path.join __dirname, 'input.txt').toString()
for string in content.split /\n/
  vowels = 0
  string.replace /[aeiou]/g, (_) -> vowels++
  hasDoubleChar = /(.)\1/.test string
  hasForbiddenSubstring = /(ab|cd|pq|xy)/.test string
  totalPart1 += vowels >= 3 and hasDoubleChar and not hasForbiddenSubstring

  hasDoubleTupleWithPossibleGap = /(..).*\1/.test string
  hasDoubleWithGapOfOne = /(.).\1/.test string
  totalPart2 += hasDoubleTupleWithPossibleGap and hasDoubleWithGapOfOne

console.log 'Part 1', totalPart1
console.log 'Part 2', totalPart2
