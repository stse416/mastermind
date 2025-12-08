require_relative "board"

class Game
  attr_reader :board

  def initialize
    @board = Board.new
    @game_over = false
  end

  def start_game
    puts "Game Start!"
    start_turn while @game_over == false
  end

  private

  def start_turn
    puts "Input 4 digit guess or 'h' for history"
    input = gets.chomp

    if input.match?(/h/i) && input.length == 1
      board.show_history
    elsif board.code_valid?(input)
      board.guess_code(input)
    end
  end

  def check_win?(guess)
    return false unless code == guess

    @game_over = true
    true
  end
end
