require_relative "board"

class Game
  attr_reader :board

  def initialize
    @code_breaker = human_or_computer
    @board = Board.new(@code_breaker)
    @game_over = false
    @attempts = 0
  end

  def start_game
    start_turn_human while @game_over == false if @code_breaker == "human"
    start_turn_comp while @game_over == false if @code_breaker == "computer"
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
      input = input.chars
      if board.check_win?(input)
        @game_over = true
        puts "\nCorrect! You've broken the code #{board.code.join(' ')} in #{@attempts} attempts!"
        puts "Attempt History:"
        board.show_history

      else
        board.guess_code(input)
      end
    end
  end

  def start_turn_comp
  end

  def human_or_computer
    puts "Game Start!
    Press 1 to break a randomized code.
    Press 2 to create a code for the computer to break"
    return "human" if gets.chomp == "1"

    Computer.new
  end
end
