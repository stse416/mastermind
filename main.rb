def randomize_code
  Array.new(4).map { rand(1..6) }
end

def guess_code(string)
  string.chars("")
end

def code_valid?(string)
  return false if string.match(/[^1-6]/) || string.length != 4

  true
end

def return_hint(code, guess_array)
  # Create a hash for the code on its creation that counts the amount of each #
  # [1, 1, 2, 2] => count = {1: 2, 2: 2}
  # Probably move this to initialization in board class later
  code_count = {}
  code.each { |num| code_count[num] ? code_count[num] += 1 : code_count[num] = 1 }

  matches = {}
  guess_array.each_index do |index|
    guess = guess_array[index]
    next unless code_count[guess]

    matches[guess] = [guess_array.count(guess), code_count[guess]].min unless matches[guess]

    if code[index] == guess
      feedback.push("o")
      matches[guess] -= 1
    end
  end

  feedback = []
  matches.each_value { |value| value.times { feedback.push("x") } }

  feedback
end

p code_valid?("")
