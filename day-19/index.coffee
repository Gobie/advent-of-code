fs = require 'fs'
path = require 'path'

state =
  replacements: {}
  molecule: null
content = fs.readFileSync(path.join __dirname, 'input.txt').toString()
for command in content.split /\n/
  command.replace /^(\S+)\s=>\s(\S+)$/g, (_, from, to) ->
    state.replacements[from] ?= []
    state.replacements[from].push to
  command.replace /^\S+$/g, (molecule) ->
    state.molecule = molecule
state

molecules = []
for from, toArr of state.replacements
  newMolecule = state.molecule.replace new RegExp(from, 'g'), (_, index) ->
    for to in toArr
      before = state.molecule.slice 0, index
      after = state.molecule.slice index + from.length
      newMolecule = before + to + after
      molecules.push newMolecule if newMolecule not in molecules

console.log 'Part 1', molecules.length

regexParts = (replacement for replacement of state.replacements)
regexParts = regexParts.concat ['Rn', 'Ar', 'Y', 'C'] # borders, separator and non-mapped atoms
elementsRegex = "(#{regexParts.join '|'})"
elements = state.molecule.match(new RegExp elementsRegex, 'g').length
borders = state.molecule.match(/(Rn|Ar)/g).length
separators = state.molecule.match(/Y/g).length

console.log 'Part 2', elements - 1 - 2 * separators - borders

