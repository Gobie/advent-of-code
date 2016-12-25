fs = require 'fs'
path = require 'path'
crypto = require 'crypto'

content = fs.readFileSync(path.join __dirname, 'input.txt').toString()

getHashStartingWith = (string, index) ->
  hash = ''
  while string isnt hash.substr 0, string.length
    md5 = crypto.createHash 'md5'
    md5.update "#{content}#{++index}"
    hash = md5.digest 'hex'
  [hash, index]

getFirstPassword = ->
  password = ''
  index = 0
  for i in [1..8]
    [hash, index] = getHashStartingWith '00000', index
    password += hash[5]
  password

getSecondPassword = ->
  positions = [0, 1, 2, 3, 4, 5, 6, 7]
  index = 0
  password = []

  while positions.length
    [hash, index] = getHashStartingWith '00000', index
    i = positions.findIndex (position) -> position is +hash[5]
    if i isnt -1
      password[+hash[5]] = hash[6]
      positions.splice i, 1

  password.join ''

console.log 'Part 1', getFirstPassword()
console.log 'Part 2', getSecondPassword()
