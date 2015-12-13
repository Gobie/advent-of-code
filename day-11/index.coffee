fs = require 'fs'
path = require 'path'

password = fs.readFileSync(path.join __dirname, 'input.txt').toString()

chars = 'abcdefghijklmnopqrstuvwxyz'
ordA = chars.charCodeAt 0

toNumber = (password) ->
  number = 0
  for char, i in password
    number += chars.length ** (password.length - i - 1) * (chars.indexOf(char) + 1)
  number

toString = (number) ->
  string = ''
  while number >= 0
    string = String.fromCharCode(number % chars.length + ordA) + string
    number = Math.floor(number / chars.length) - 1
  string

isValid = (password) ->
  hasSequenceOfThree(password) and hasTwoDifferentDoubles(password) and not /[iol]/.test(password)

hasSequenceOfThree = (password) ->
  c1 = c2 = c3 = 0
  for c in password
    c1 = c2
    c2 = c3
    c3 = c.charCodeAt 0
    return yes if c3 is c2 + 1 is c1 + 2
  no

hasTwoDifferentDoubles = (password) ->
  possibleDouble = ''
  firstDouble = ''
  for c in password
    if c is possibleDouble
      return yes if firstDouble
      firstDouble = possibleDouble
      possibleDouble = ''
    else if c isnt firstDouble
      possibleDouble = c
  no

generateNewPassword = (password) ->
  passwordNumber = toNumber password
  newPassword = ''
  newPassword = toString passwordNumber++ until isValid newPassword
  newPassword

console.log 'Part 1', newPassword = generateNewPassword password
console.log 'Part 2', generateNewPassword newPassword
