fs = require "fs"
randomJs = require "random-js"

feed = (file) ->
  read = fs.readFileSync file, "utf8"
  lines = read.split "\n"
  #combs = ((Number num for num in line.split ", ") for line in lines)
  combs = (line.split ", " for line in lines)
  combs.pop()
  combs

not_in = (e, es) ->
  if e not in es
    return true
  return false

get_most_nums = (combs, number) ->
  frequency = {}
  nums = []
  for comb in combs
    for c in comb
      frequency[c] = (frequency[c] || 0) + 1
      if not_in c, nums then nums.push c
  sort = nums.sort (a, b) -> frequency[b] - frequency[a]
  Number num for num in sort.filter (e, i) -> i < number

combinations = []
most = 13
most_nums = get_most_nums (feed "combs"), most

rand = (min, max) ->
  random = new randomJs randomJs.engines.mt19937().autoSeed()
  random.integer min, max

not_in_combination = (num, comb) ->
    not_in num, comb

not_in_combinations = (comb, combs) ->
  not_in comb, combs

random_combination = (combs) ->
    comb = []
    random_num = ->
      r = most_nums[rand(0, most - 1)]
      if not_in_combination r, comb
        return r
      return random_num()
    for i in [0..5]
      comb[i] = random_num()
    if not_in_combinations comb, combs
      return comb
    return random_combination combs

most_nums_combination = (combs, most_nums) ->

for i in [0..3]
  combinations[i] = random_combination(combinations)
#combinations[1] = most_combinations_combination(combinations, most_combinations)
#combinations[2] = most_nums_combination(combinations, most_nums)
#combinations[3] = hybrid_combination(combinations, most_combinations, most_nums)

console.log combinations
