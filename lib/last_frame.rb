class LastFrame < Frame

  def add_bowl(pins)
    raise 'Frame is finished' if self.finished?
    raise 'Invalid pin number' if (@pins_left - pins < 0 && extra_rolls == 0) || pins > PIN_COUNT

    @pins_left -= pins unless (extra_rolls > 0 && @pins_left == 0)
    @bowls << pins
  end

  def extra_rolls
    if strike?
      2
    elsif spare?
      1
    else
      0
    end
  end

  def finished?
    (extra_rolls == 0 && @bowls.size == 2) || (extra_rolls > 0 && @bowls.size == 3)
  end
end