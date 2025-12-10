class Board
  attr_reader :code

  def initialize(human_or_comp)
    @code = create_code(human_or_comp)
    @code_count = count_code(@code)
    @history = []
  end

  def guess_code(guess)
    hint = return_hint(guess)
    add_history(guess, hint)

    puts "Hint: #{hint}"
  end

  def code_valid?(string)
    if string.match(/[^1-6]/) || string.length != 4
      puts "Invalid entry."
      return false
    end

    true
  end

  def return_hint(guess_array)
    feedback = []
    matches = {}

    guess_array.each_with_index do |guess, index|
      next unless @code_count[guess]

      matches[guess] = [guess_array.count(guess), @code_count[guess]].min unless matches[guess]

      if @code[index] == guess
        feedback.push("o")
        matches[guess] -= 1
      end
    end

    matches.each_value { |value| value.times { feedback.push("x") } }

    feedback
  end

  def return_comp_hint(guess_array)
    feedback = []
    matches = {}

    guess_array.each_with_index do |guess, index|
      unless @code_count[guess]
        feedback.push("b")
        next
      end

      matches[guess] = [guess_array.count(guess), @code_count[guess]].min unless matches[guess]

      if code[index] == guess
        feedback.push("o")
      elsif matches[guess] - @code_count[guess] > 0
        feedback.push("x")
        matches[guess] -= 1
      else
        feedback.push("b")
      end
    end

    feedback
  end

  def show_history
    turn = 0
    @history.each do |ele|
      turn += 1
      puts "#{turn}: #{ele[0].join(' ')} => #{ele[1].join(' ')}"
    end
  end

  def check_win?(guess)
    return false unless code == guess

    add_history(guess, %w[o o o o])
    true
  end

  private

  def create_code(breaker)
    return randomize_code if breaker == "human"

    puts "\nEnter your 4 digit code composed of the numbers 1-6"
    input = gets.chomp
    input.to_i.digits.reverse if code_valid?(input)
  end

  def randomize_code
    Array.new(4).map { rand(1..6) }
  end

  def count_code(arr)
    count = {}
    arr.each { |num| count[num] ? count[num] += 1 : count[num] = 1 }

    count
  end

  def add_history(guess, hint)
    @history.push([guess, hint])
  end
end
