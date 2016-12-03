fs = require 'fs'
path = require 'path'

instructionMap =  (world) ->
  jmp: (offset) ->
    world.pos += offset
  jio: (register, offset) ->
    return @jmp offset if world.registers[register] is 1
    world.pos++
  jie: (register, offset) ->
    return @jmp offset unless world.registers[register] % 2
    world.pos++
  hlf: (register) ->
    world.registers[register] /= 2
    world.pos++
  tpl: (register) ->
    world.registers[register] *= 3
    world.pos++
  inc: (register) ->
    world.registers[register]++
    world.pos++

createWorld = (a, b) ->
  world =
    registers: {a, b}
    instructions: []
    pos: 0
  content = fs.readFileSync(path.join __dirname, 'input.txt').toString()
  for command in content.split /\n/
    command.replace /^(\S+) ([^+-]+), ([+-]\d+)$/, (_, name, register, offset) ->
      world.instructions.push {name, args: [register, +offset]}
    command.replace /^(\S+) ([+-]\d+)$/, (_, name, offset) ->
      world.instructions.push {name, args: [+offset]}
    command.replace /^(\S+) ([^+-]+)$/, (_, name, register) ->
      world.instructions.push {name, args: [register]}
  world

world = createWorld 0, 0
map = instructionMap world
while world.pos < world.instructions.length
  instruction = world.instructions[world.pos]
  map[instruction.name].apply map, instruction.args

console.log 'Part 1', world.registers.b

world = createWorld 1, 0
map = instructionMap world
while world.pos < world.instructions.length
  instruction = world.instructions[world.pos]
  map[instruction.name].apply map, instruction.args

console.log 'Part 2', world.registers.b
