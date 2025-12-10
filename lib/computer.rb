class Computer
  attr_accessor :board

  def initialize
    @board = nil
    @history = []
  end

  def guess_code
    if @history.empty?
      guess = Array.new(4).map { rand(1..6) }
    else
      prev_guess = @history[@history.length - 1][0]
      prev_hint = @history[@history.length - 1][1]
      pool = []
      matches = 0

      prev_hint.each_with_index do |hint, index|
        pool.push(prev_guess[index]) if hint == "x"
        matches += 1 if hint == "o"
      end

      guess = pool.shuffle
      guess.insert(rand(0..guess.length), rand(1..6)) while guess.length + matches < 4

      prev_hint.each_with_index do |hint, index|
        guess.insert(index, prev_guess[index]) if hint == "o"
      end
    end

    @history.push([guess, @board.return_comp_hint(guess)])
    guess
  end

  def show_history
    turn = 0
    @history.each do |ele|
      turn += 1
      puts "#{turn}: #{ele[0].join(' ')} => #{ele[1].join(' ')}"
    end
  end
end
