fs = require 'fs'
path = require 'path'

edges = []
vertices = {}

content = fs.readFileSync(path.join __dirname, 'input.txt').toString()
for route in content.split /\n/
  route.replace /^(\S+) to (\S+) = (\d+)$/, (_, from, to, distance) ->
    edges.push [from, to, +distance]
    edges.push [to, from, +distance]
    vertices[from] = vertices[to] = yes

verticeNames = Object.keys vertices
numVertices = verticeNames.length

findDistances = (from, to, route = [], routeDistance = 0) ->
  route = route.concat from

  distances = []
  for [source, destination, distance] in edges when (source is from and destination not in route)
    if destination is to
      continue if route.length isnt numVertices - 1
      return routeDistance + distance

    distances = distances.concat findDistances destination, to, route, routeDistance + distance
  distances

distances = []
for from in verticeNames
  for to in verticeNames when from isnt to
    distances = distances.concat findDistances from, to

console.log 'Part 1', Math.min.apply Math, distances
console.log 'Part 2', Math.max.apply Math, distances
