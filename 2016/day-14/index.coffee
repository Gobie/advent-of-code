fs = require 'fs'
path = require 'path'
crypto = require 'crypto'

content = fs.readFileSync(path.join __dirname, 'input.txt').toString()

stretchHash = (hash, n) ->
  i = 0
  while i++ < n
    hash = getHash hash
  hash

getHash = (string) ->
  md5 = crypto.createHash 'md5'
  md5.update string
  md5.digest 'hex'

getSameCharsOfLengthN = (string, n) ->
  out = ''
  for l in string
    if l is out[0]
      out += l
      return out if out.length is n
    else
      out = l
  ''

isCandidate = (hash, index, candidates) ->
  if seq = getSameCharsOfLengthN hash, 3
    candidates.push {hash, index, seq}
    return yes
  no

isAccepted = (hash, index, candidates, keys) ->
  out = no
  if seq = getSameCharsOfLengthN hash, 5
    i = 0
    while i < candidates.length
      if candidates[i].index + 1000 < index
        candidates.splice i, 1
      else if candidates[i].seq is seq[0..2]
        keys.push {candidate: candidates[i], verifier: {hash, index, seq}}
        candidates.splice i, 1
        out = yes
      else
        i++
  out

getKeys = (content, n, stretchNTime) ->
  keys = []
  candidates = []
  index = 0

  while keys.length < n
    hash = getHash "#{content}#{index}"
    hash = stretchHash hash, stretchNTime
    unless isAccepted hash, index, candidates, keys
      isCandidate hash, index, candidates
    index++

  keys

keys = getKeys content, 64, 0
keys = keys.sort (a, b) ->
  a.candidate.index - b.candidate.index

console.log 'Part 1', keys.pop()

keys = getKeys content, 64, 2016
keys = keys.sort (a, b) ->
  a.candidate.index - b.candidate.index

console.log 'Part 2', keys.pop()
