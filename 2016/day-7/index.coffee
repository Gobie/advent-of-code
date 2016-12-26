fs = require 'fs'
path = require 'path'

content = fs.readFileSync(path.join __dirname, 'input.txt').toString()
ips = content.split '\n'

detectABBA = (word) ->
  for i in [0...word.length-3]
    if word[i] is word[i+3] and
    word[i+1] is word[i+2] and
    word[i] isnt word[i+1]
      return true
  false

detectTLS = (ip) ->
  hadABBA = false
  for part, i in ip.split /[\[\]]/
    isHypernet = i % 2 == 1
    hasABBA = detectABBA part
    return false if isHypernet and hasABBA
    hadABBA ||= hasABBA
  hadABBA

total = 0
for ip in ips
  total += detectTLS ip

console.log 'Part 1', total

getABAs = (word) ->
  out = []
  for i in [0...word.length-2]
    if word[i] is word[i+2] and word[i] isnt word[i+1]
      out.push word[i..i+2]
  out

compareABAvsBAB = (a, b) ->
  a[0..1] is b[1..2]

detectSSL = (ip) ->
  hypernet = []
  supernet = []

  for part, i in ip.split /[\[\]]/
    if i % 2 == 1
      hypernet = hypernet.concat getABAs part
    else
      supernet = supernet.concat getABAs part

  for h in hypernet
    for s in supernet
      if compareABAvsBAB h, s
        return true

  false

total = 0
for ip in ips
  total += detectSSL ip

console.log 'Part 2', total
