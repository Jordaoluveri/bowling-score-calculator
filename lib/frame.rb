class Frame
  PIN_COUNT = 10

  attr_accessor :bowls, :pins_left, :points, :accumulated_score

  def initialize
    @bowls = []
    @points = 0
    @accumulated_score = 0
    @pins_left = PIN_COUNT
  end

  def add_bowl(pins)
    raise 'Frame is finished' if self.finished?
    raise 'Invalid pin number' if @pins_left - pins < 0 || pins < 0
    @pins_left -= pins.to_i || 0
    @bowls << pins
  end

  def strike?
    @bowls[0] == PIN_COUNT
  end

  def spare?
    (@bowls.size > 1 && @bowls.take(2).sum == PIN_COUNT) && !strike?
  end

  def gutter?
    @bowls.take(2).sum == 0
  end

  def finished?
    @pins_left.zero? || @bowls.size == 2
  end

  def last_frame?
    self.class.to_s == 'LastFrame'
  end
end