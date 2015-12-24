fs = require 'fs'
path = require 'path'

createWorld = ->
  world =
    boss: {}
  content = fs.readFileSync(path.join __dirname, 'input.txt').toString()
  for command in content.split /\n/
    command.replace /^([^:]+): (\d+)$/, (_, name, value) ->
      world.boss[if name is 'Hit Points' then 'health' else name.toLowerCase()] = +value
  world

findMinimum = (part, maxTurns) ->
  min = Infinity
  world = createWorld()

  simulate = (effects, playerHealth, armor, mana, cost, bossHealth, turn = 0) ->
    return if turn > maxTurns

    playerHealth-- if part is 2

    # apply effects
    if effects >= 100
      effects -= 100
      armor -= 7 if effects < 100
    if (effects % 100) >= 10
      effects -= 10
      bossHealth -= 3
    if (effects % 10) >= 1
      effects -= 1
      mana += 101

    # player killed
    return if playerHealth <= 0

    # boss killed
    if bossHealth <= 0
      min = cost if cost < min
      return

    # boss's turn
    if turn % 2
      simulate effects, playerHealth - Math.max(1, (world.boss.damage - armor)), armor, mana, cost, bossHealth, turn + 1

    # player's turn
    else
      for spell in ['MagicMissile', 'Drain', 'Shield', 'Poison', 'Recharge']
        switch spell
          when 'MagicMissile'
            continue if mana < 53
            simulate effects, playerHealth, armor, mana - 53, cost + 53, bossHealth - 4, turn + 1
          when 'Drain'
            continue if mana < 73
            simulate effects, playerHealth + 2, armor, mana - 73, cost + 73, bossHealth - 2, turn + 1
          when 'Shield'
            continue if mana < 113 or effects >= 100
            simulate effects + 600, playerHealth, armor + 7, mana - 113, cost + 113, bossHealth, turn + 1
          when 'Poison'
            continue if mana < 173 or (effects % 100) >= 10
            simulate effects + 60, playerHealth, armor, mana - 173, cost + 173, bossHealth, turn + 1
          when 'Recharge'
            continue if mana < 229 or (effects % 10) >= 1
            simulate effects + 5, playerHealth, armor, mana - 229, cost + 229, bossHealth, turn + 1

  simulate 0, 50, 0, 500, 0, world.boss.health, 0
  min

console.log 'Part 1', findMinimum 1, 20
console.log 'Part 2', findMinimum 2, 20
