class Computer
  def guess_code(prev_hint = nil)
    if prev_hint
      "blah"
    else
      code = Array.new(4).map { rand(1..6) }
    end
    code
  end
end
