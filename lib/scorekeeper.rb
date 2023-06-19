class Scorekeeper

  attr_reader :total

  def initialize(frames)
    @frames = frames
    calculate_points
    calculate_accumulated_score
    @total = 0
    @frames.each { |frame| @total += frame.points }
  end

  private

  def calculate_points
    @frames.each_with_index do |frame, index|
      if frame.last_frame? || (!frame.strike? && !frame.spare?)
        frame.points = frame.bowls.sum
      else
        frame.points = frame.bowls.sum + next_n_bowls_value(index)
      end
    end
  end

  def calculate_accumulated_score
    @frames.each_with_index do |frame, index|
      if index == 0
        frame.accumulated_score = frame.points
      else
        frame.accumulated_score = frame.points + @frames[index-1].accumulated_score
      end
    end
  end

  def next_n_bowls_value(index)
    if @frames[index].strike?
      return @frames[index+1].bowls.take(2).sum if @frames[index+1].bowls.size > 1

      @frames[index+1].bowls.first + @frames[index+2].bowls.first
    elsif @frames[index].spare?
      @frames[index+1].bowls.first
    end
  end
end