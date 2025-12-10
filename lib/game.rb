require_relative "board"
require_relative "computer"

class Game
  attr_reader :board

  def initialize
    @computer = nil
    @board = Board.new(human_or_computer)
    @game_over = false
    @attempts = 0
  end

  def start_game
    if @computer
      @computer.board = @board
      start_turn_comp while @game_over == false
    else
      start_turn_human while @game_over == false
    end
  end

  private

  def start_turn_human
    puts "\nInput 4 digit guess or 'h' for history"
    input = gets.chomp

    p board.code if input.match(/c/i) && input.length == 1 # Hacks for testing

    if input.match(/h/i) && input.length == 1 then board.show_history
    else
      return unless board.code_valid?(input)

      @attempts += 1
      input = input.to_i.digits.reverse
      if board.check_win?(input)
        @game_over = true
        puts "\nCorrect! You've broken the code '#{board.code.join(' ')}' in #{@attempts} attempts!"
        puts "Attempt History:"
        board.show_history

      else
        board.guess_code(input)
      end
    end
  end

  def start_turn_comp
    @attempts += 1
    input = @computer.guess_code

    return unless board.check_win?(input)

    @game_over = true
    puts "\nComputer has broken the code '#{board.code.join(' ')}' after #{@attempts} attempts!"
    puts "Attempt History:"
    @computer.show_history
  end

  def human_or_computer
    puts "Game Start!
    Press 1 to break a randomized code.
    Press any other key to create a code for the computer to break"
    return "human" if gets.chomp == "1"

    @computer = Computer.new
    "computer"
  end
end
