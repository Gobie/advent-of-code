fs = require 'fs'
path = require 'path'

content = fs.readFileSync(path.join __dirname, 'input.txt').toString()

countHouses = (withRobot) ->
  counter = 0
  houses =
    'x0y0': yes
  positions =
    santa:
      x: 0
      y: 0
    robot:
      x: 0
      y: 0

  for size in content.split /\n/
    size.replace /./g, (direction) ->
      position = if (counter += withRobot) % 2 then positions.santa else positions.robot

      switch direction
        when '^' then position.y++
        when 'v' then position.y--
        when '>' then position.x++
        when '<' then position.x--

      houses["x#{position.x}y#{position.y}"] = yes

  total = 0
  total += value for _, value of houses
  total

console.log 'Part 1', countHouses no
console.log 'Part 2', countHouses yes
