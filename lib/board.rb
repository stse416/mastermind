class Board
  attr_reader :code

  def initialize
    @code = randomize_code
    @code_count = count_code
    @history = []
  end

  def guess_code(string)
    string.chars("")
  end

  def code_valid?(string)
    return false if string.match(/[^1-6]/) || string.length != 4

    true
  end

  def return_hint(code, guess_array)
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

  def show_history
    puts @history
  end

  private

  def randomize_code
    Array.new(4).map { rand(1..6) }
  end

  def count_code
    count = {}
    code.each { |num| count[num] ? count[num] += 1 : count[num] = 1 }

    count
  end

  def add_history(guess, hint)
    history.push(guess, hint)
  end
end
