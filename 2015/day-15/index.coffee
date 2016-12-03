fs = require 'fs'
path = require 'path'

ingredients = {}

content = fs.readFileSync(path.join __dirname, 'input.txt').toString()
for route in content.split /\n/
  route.replace /^([^:]+): capacity ([\d-]+), durability ([\d-]+), flavor ([\d-]+), texture ([\d-]+), calories ([\d-]+)$/, (_, name, capacity, durability, flavor, texture, calories) ->
    ingredients[name] =
      capacity: +capacity
      durability: +durability
      flavor: +flavor
      texture: +texture
      calories: +calories

calcScore = (ratios) ->
  total = 1
  for attr in ['capacity', 'durability', 'flavor', 'texture']
    ingredientTotal = 0
    for ingredient, spoons of ratios
      ingredientTotal += ingredients[ingredient][attr] * spoons
    total *= Math.max 0, ingredientTotal
  total

calcScoreWithCalories = (ratios) ->
  total = 1
  for attr in ['capacity', 'durability', 'flavor', 'texture', 'calories']
    ingredientTotal = 0
    for ingredient, spoons of ratios
      ingredientTotal += ingredients[ingredient][attr] * spoons
    if attr is 'calories'
      total *= 0 unless ingredientTotal is 500
    else
      total *= Math.max 0, ingredientTotal
  total

getPermutations = (ratios, ingredients, spoonsLeft, acc) ->
  if ingredients.length is 0
    return unless spoonsLeft is 0
    ratio = {}
    for [ingredient, spoons] in ratios
      ratio[ingredient] = spoons
    acc.push ratio
    return

  ingredient = ingredients.pop()
  for i in [0..spoonsLeft]
    ratios.push [ingredient, i]
    getPermutations ratios, ingredients, spoonsLeft - i, acc
    ratios.pop()
  ingredients.push ingredient
  return

perms = []
getPermutations [], (ingredient for ingredient of ingredients), 100, perms

filterOutZeros = perms.map(calcScore).filter(Boolean)
console.log 'Part 1', Math.max.apply Math, filterOutZeros

filterOutZeros = perms.map(calcScoreWithCalories).filter(Boolean)
console.log 'Part 2', Math.max.apply Math, filterOutZeros
