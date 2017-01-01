fs = require 'fs'
path = require 'path'

content = fs.readFileSync(path.join __dirname, 'input.txt').toString()

repeat = (str, n) ->
  out = ''
  loop
    out += str if n % 2
    str += str if n = Math.floor n / 2
    break unless n
  out

getLength = (content, recursive) ->
  unless match = content.match /\((\d+)x(\d+)\)/
    return content.length

  start = match.index
  markerLength = match[0].length
  markerChars = +match[1]
  markerTimes = +match[2]

  len = start
  repeated = repeat content.substr(start + markerLength, markerChars), markerTimes
  if recursive
    len += getLength repeated, recursive
  else
    len += repeated.length
  len += getLength content.substr(start + markerLength + markerChars), recursive
  len

console.log 'Part 1', getLength content, no
console.log 'Part 2', getLength content, yes