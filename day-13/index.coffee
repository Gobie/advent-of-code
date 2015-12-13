fs = require 'fs'
path = require 'path'

createState = ->
  vertices = {}

  content = fs.readFileSync(path.join __dirname, 'input.txt').toString()
  for route in content.split /\n/
    route.replace /^(\S+) would (\S+) (\d+) happiness units by sitting next to (\S+)\.$/, (_, from, type, happiness, to) ->
      sign = if type is 'gain' then 1 else -1
      vertices[from] ?= {}
      vertices[from][to] ?= 0
      vertices[from][to] += sign*happiness
      vertices[to] ?= {}
      vertices[to][from] ?= 0
      vertices[to][from] += sign*happiness

  {vertices, verticeNames: Object.keys vertices}

findDistances = (vertices, from, to, route = [], routeHappiness = 0) ->
  route = route.concat from
  distances = []
  for destination, happiness of vertices[from] when destination not in route[1..]
    if destination is to
      continue if route.length isnt Object.keys(vertices).length
      return routeHappiness + happiness

    distances = distances.concat findDistances vertices, destination, to, route, routeHappiness + happiness
  distances

{vertices, verticeNames} = createState()
console.log 'Part 1', Math.max.apply Math, findDistances vertices, verticeNames[0], verticeNames[0]

{vertices, verticeNames} = createState()
vertices['me'] = {}
for verticeName in verticeNames
  vertices['me'][verticeName] = 0
  vertices[verticeName]['me'] = 0
console.log 'Part 2', Math.max.apply Math, findDistances vertices, verticeNames[0], verticeNames[0]
