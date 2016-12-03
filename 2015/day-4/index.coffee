fs = require 'fs'
path = require 'path'
crypto = require 'crypto'

content = fs.readFileSync(path.join __dirname, 'input.txt').toString()

findIndexForHashStartingWith = (string) ->
  index = 0
  hash = ''
  while string isnt hash.substr 0, string.length
    md5 = crypto.createHash 'md5'
    md5.update "#{content}#{++index}"
    hash = md5.digest 'hex'
  index

console.log 'Part 1', findIndexForHashStartingWith '00000'
console.log 'Part 1', findIndexForHashStartingWith '000000'
