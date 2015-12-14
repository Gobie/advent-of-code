fs = require 'fs'
path = require 'path'

reindeers = {}

content = fs.readFileSync(path.join __dirname, 'input.txt').toString()
for route in content.split /\n/
  route.replace /^(\S+) can fly (\d+) km\/s for (\d+) seconds, but then must rest for (\d+) seconds.$/, (_, name, speed, travelTime, restTime) ->
    reindeers[name] = [+speed, +travelTime, +restTime]

move = (state, reindeers) ->
  for name, [speed, travelTime, restTime] of reindeers
    if state[name].progress > 0
      state[name].distance += speed
      state[name].progress = -restTime if --state[name].progress is 0
    else
      state[name].progress = travelTime if ++state[name].progress is 0

  return

calculatePoints = (state) ->
  winners = []
  max = 0
  for name of state
    if state[name].distance > max
      max = state[name].distance
      winners = [name]
    else if state[name].distance is max
      winners.push name

  for winner in winners
    state[winner].points++

  return

state = {}
for name, [_, travelTime, _] of reindeers
  state[name] =
    points: 0
    distance: 0
    progress: travelTime

for i in [1..2503]
  move state, reindeers
  calculatePoints state

console.log 'Part 1', Math.max.apply Math, (distance for _, {distance} of state)
console.log 'Part 2', Math.max.apply Math, (points for _, {points} of state)
