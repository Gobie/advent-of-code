fs = require 'fs'
path = require 'path'

sues = {}

content = fs.readFileSync(path.join __dirname, 'input.txt').toString()
for route in content.split /\n/
  route.replace /^Sue (\d+): (\S+): (\d+), (\S+): (\d+), (\S+): (\d+)$/, (_, sueNumber, key1, val1, key2, val2, key3, val3) ->
    sues[sueNumber] = {}
    sues[sueNumber][key1] = +val1
    sues[sueNumber][key2] = +val2
    sues[sueNumber][key3] = +val3

detected =
  children: 3
  cats: 7
  samoyeds: 2
  pomeranians: 3
  akitas: 0
  vizslas: 0
  goldfish: 5
  trees: 3
  cars: 2
  perfumes: 1

find = (sues, cb) ->
  mySue =
    sueNumber: null
    score: -Infinity

  for sueNumber, stats of sues
    score = 0
    for key, val of stats when cb key, val
      score++
    mySue = {sueNumber, score} if score > mySue.score

  mySue

suePart1 = find sues, (key, val) ->
  detected[key] is val

suePart2 = find sues, (key, val) ->
  return detected[key] < val if key in ['trees', 'cats']
  return detected[key] > val if key in ['pomeranians', 'goldfish']
  return detected[key] is val

console.log 'Part 1', suePart1.sueNumber
console.log 'Part 2', suePart2.sueNumber
