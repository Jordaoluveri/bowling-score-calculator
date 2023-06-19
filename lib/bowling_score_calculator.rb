require_relative 'player'
require_relative 'frame'
require_relative 'last_frame'
require_relative 'scorekeeper'
require_relative 'score_formatter'
require_relative 'file_parser'

class BowlingScoreCalculator

  def initialize(args)
    @raw_data = FileParser.call(args.first)

    create_players
  end

  def create_players
    @players = []

    @raw_data.each do |player, pinfalls|
      @players << Player.new(player, pinfalls.map(&:to_i))
    end
  end

  def run
    ScoreFormatter.new(@players)
  end

  if $PROGRAM_NAME == __FILE__
    BowlingScoreCalculator.new(ARGV).run
  end
end