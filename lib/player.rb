class Player
  MAX_FRAMES = 10
  attr_reader :name, :pinfalls, :total_score
  attr_accessor :frames

  def initialize(name, pinfalls)
    raise "Player cant have an empty name" if name.length == 0

    @name = name
    @pinfalls = pinfalls
    @frames = []
    fill_frames(@pinfalls)
    Scorekeeper.new(self.frames)
    @total_score = total_score
  end

  def current_frame
    @frames.last
  end

  def total_score
    current_frame.accumulated_score
  end

  private

  def fill_frames(pinfalls)
    while @frames.size < 9 do
      create_frame
      until current_frame.finished? do
        current_frame.add_bowl(pinfalls.shift.to_i)
      end
    end

    create_last_frame
    until current_frame.finished? do
      current_frame.add_bowl(pinfalls.shift)
    end

    raise "Wrong number of pinfalls for player: '#{self.name}'" if pinfalls.size > 0
  end


  def create_frame
    @frames << Frame.new
  end

  def create_last_frame
    @frames << LastFrame.new
  end
end