class Computer
  def initialize
    @prev_guess = nil
    @history = []
  end

  def guess_code(prev_hint = nil)
    if prev_hint
      pool = []
      matches = 0

      prev_hint.each_with_index do |hint, index|
        pool.push(@prev_guess[index]) if hint == "x"
        matches += 1 if hint == "o"
      end

      code = pool.shuffle
      code.insert(rand(0..code.length), rand(1..6)) while code.length + matches < 4

      prev_hint.each_with_index do |hint, index|
        code.insert(index, @prev_guess[index]) if hint == "o"
      end
    else
      code = Array.new(4).map { rand(1..6) }
    end

    @prev_guess = code
    @history.push(code)
    code
  end

  def show_history
    turn = 0
    @history.each do |ele|
      turn += 1
      puts "#{turn}: #{ele[0].join(' ')} => #{ele[1].join(' ')}"
    end
  end
end
