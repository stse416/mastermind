require_relative "board"

class Game
  attr_reader :board

  def initialize
    @board = Board.new
    @game_over = false
    @attempts = 0
  end

  def start_game
    puts "Game Start!"
    start_turn while @game_over == false
  end

  private

  def start_turn
    puts "\nInput 4 digit guess or 'h' for history"
    input = gets.chomp

    p board.code if input.match(/c/i) && input.length == 1 # Hacks for testing

    if input.match(/h/i) && input.length == 1 then board.show_history
    else
      return unless board.code_valid?(input)

      input = input.chars
      if board.check_win?(input)
        @game_over = true
        puts "\nCorrect! You've broken the code in #{@attempts += 1} attempts!"
      else
        @attempts += 1
        board.guess_code(input)
      end
    end
  end
end
