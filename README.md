# mastermind
https://www.theodinproject.com/lessons/ruby-mastermind


6 colors (1, 2, 3, 4, 5, 6), 4 holes
array [1, 3, 1, 5]
Blanks not allowed. duplicates allowed




Notes:

1. Computer randomizes code [1, 3, 4, 5]
2. Player starts guessing, [6, 2, 5, 1]
    2a. Player is provided feedback based off their guess
    'o' for a correct spot, 'x' for correct num but wrong spot. Nothing otherwise.
    Order it in priority of correct before misplaced. [o, o, x]
        - [1, 3, 4, 5](code) => [6, 2, 5, 1](guess) => [x, x] (feedback)
        - [1, 3, 4, 5](code) => [1, 5, 2, 6](guess) => [o, x] (feedback)

    2b. If there are duplicate colors in the guess, they cannot all be awarded a key peg unless 
    they correspond to the same number of duplicate colors in the hidden code. For example,
    if the hidden code is red-red-blue-blue and the codebreaker places red-red-red-blue, the
    codemaker will award three colored key pegs for the first two reds and the blue, but nothing
    for the third red. No indication is given of the fact that the code also includes a second blue.
        - [1, 1, 2, 2](code) => [1, 1, 1, 2](guess) => [o, o, o] (feedback)

3. Repeat step 2 until turn limit reached (or if no turn limit, player succeeds?)


Pseudo:
  # - [1, 1, 2, 2](code) => [1, 1, 1, 2](guess) => [o, o, o] (feedback)

  # Create a hash for the code on its creation that counts the amount of each #
  # [1, 1, 2, 2] => count = {1: 2, 2: 2}
  #   - Possibly move this to initialization in board class later

  # Create a "matches" hash {}
  # %w[1 1 1 2]

# 1. On new index, check if # exists in code.
  #   No? Skip.
  #   Yes? Does it exist in matches hash? (matches[2] ?)
  #     No? Put how many there are in the guess array that match code array.
  #     {}[x] = [guess_array.count(2), code_array.count(2)].min     ->  matches = {2: 2}
  # 2. Is the current index a spot match for the code?
  #   - Yes? Remove an 'x' from matches ({}[#] -= 1). Feedback array .push ['o']
  #   - No? Next index.
  # 3. After all index. Add the remaining values for each key.
  #   - Push 'x' to feedback array for each.



Return hint tests:
puts "#{return_hint(%w[1 1 2 2], %w[1 1 1 2])} expected: [o, o, o]"
puts "#{return_hint(%w[1 3 4 5], %w[6 2 5 1])} expected: [x, x]"
puts "#{return_hint(%w[1 3 4 5], %w[1 5 2 6])} expected: [o, x]"
puts "#{return_hint(%w[1 1 1 1], %w[2 3 4 5])} expected: []"
puts "#{return_hint(%w[2 2 4 5], %w[2 1 5 4])} expected: [o, x, x]"


Implementing cpu play:
  If you choose to modify the rules, you can provide the computer additional information about each guess. For example, you can start by having the computer guess randomly, but keep the ones that match exactly. You can add a little bit more intelligence to the computer player so that, if the computer has guessed the right color but the wrong position, its next guess will need to include that color somewhere.


Comp hint tests:
puts "#{return_comp_hint(%w[1 2 1 3], %w[1 1 2 3])} => [o x x o]"
puts "#{return_comp_hint(%w[2 1 3 1], %w[1 1 2 3])} => [x o x x]"
puts "#{return_comp_hint(%w[3 1 2 5], %w[1 1 3 5])} => [x o b o]"
puts "#{return_comp_hint(%w[2 4 2 2], %w[5 2 2 4])} => [x x o b]"
puts "#{return_comp_hint(%w[5 2 2 4], %w[2 4 2 2])} => [b x o x]"
