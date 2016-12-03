fs = require 'fs'
path = require 'path'

createWorld = ->
  world =
    boss: {}
    items: {}
  itemType = null
  content = fs.readFileSync(path.join __dirname, 'input.txt').toString()
  for command in content.split /\n/
    command.replace /^([^:]+): (\d+)$/, (_, name, value) ->
      world.boss[if name is 'Hit Points' then 'health' else name.toLowerCase()] = +value
    command.replace /^(\S+(?:\s\+\d)?)\s+(\d+)\s+(\d+)\s+(\d+)$/, (_, name, cost, damage, armor) ->
      world.items[name] =
        name: name
        type: itemType
        cost: +cost
        damage: +damage
        armor: +armor
    command.replace /^([^:]+):\s+Cost\s+Damage\s+Armor$/, (_, type) ->
      itemType = type
  world

createPlayer = ->
  health: 100
  damage: 0
  armor: 0
  cost: 0

isWinningScenario = (player, boss) ->
  turns = Math.ceil boss.health / Math.max(1, player.damage - boss.armor)
  player.health > Math.max(1, boss.damage - player.armor) * (turns - 1)

subsets = (input, from, to) ->
  results = []
  total = 2 ** input.length
  mask = -1
  while ++mask < total
    result = []
    i = input.length - 1
    loop
      result.push input[i] unless (mask & 1 << i) is 0
      break unless i--
    results.push result if from <= result.length <= to
  results

pickItems = (items, type) ->
  item for name, item of items when item.type is type

equipPlayer = (items) ->
  player = createPlayer()
  for item in items
    player.damage += item.damage
    player.armor += item.armor
    player.cost += item.cost
  player.items = items
  player

world = createWorld()
weaponsSets = pickItems world.items, 'Weapons'
armorSets = subsets pickItems(world.items, 'Armor'), 0, 1
ringsSets = subsets pickItems(world.items, 'Rings'), 0, 2

minimumPlayer = cost: Infinity
maximumPlayer = cost: -Infinity

for weapon in weaponsSets
  for armor in armorSets
    for ring in ringsSets
      player = equipPlayer [].concat weapon, armor, ring

      if isWinningScenario player, world.boss
        minimumPlayer = player if minimumPlayer.cost > player.cost
      else
        maximumPlayer = player if maximumPlayer.cost < player.cost

console.log 'Part 1', minimumPlayer.cost
console.log 'Part 2', maximumPlayer.cost
