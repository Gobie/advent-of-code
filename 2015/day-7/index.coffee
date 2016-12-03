fs = require 'fs'
path = require 'path'

actions =
  AND: (l, r) -> l & r
  OR: (l, r) -> l | r
  LSHIFT: (l, r) -> (l << r) % 2 ** 16
  RSHIFT: (l, r) -> l >> r
  NOT: (l, r) -> 2 ** 16 - 1 - r

createState = ->
  state = {}
  content = fs.readFileSync(path.join __dirname, 'input.txt').toString()
  for command in content.split /\n/
    command
    .replace /^(\S+) (\S+) (\S+) -> (\S+)$/, (_, l, action, r, result) -> state[result] = [l, action, r]
    .replace /^(\S+) (\S+) -> (\S+)$/, (_, action, r, result) -> state[result] = [null, action, r]
    .replace /^(\S+) -> (\S+)$/, (_, r, result) -> state[result] = [null, null, r]
  state

getValue = (state, val) ->
  if not val?
    0
  else if /\D/.test val
    res = exec state, state[val]
    state[val] = [null, null, res] # replace calculation for the result
    res
  else
    +val

exec = (state, [l, action, r]) ->
  if action
    actions[action] getValue(state, l), getValue(state, r)
  else
    getValue state, r

statePart1 = createState()
console.log 'Part 1', resultPart1 = exec statePart1, statePart1['a']

statePart2 = createState()
statePart2['b'] = [null, null, resultPart1]
console.log 'Part 2', exec statePart2, statePart2['a']
