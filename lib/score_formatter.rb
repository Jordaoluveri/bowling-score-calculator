require 'terminal-table'

class ScoreFormatter

  def initialize(players)
    @players = players
    @players_rows = []
    print_game
  end

  def print_game
    heading = ['Frame', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10']
    rows = []

    @table = Terminal::Table.new do |t|
      t.headings = heading
      t.rows = rows
    end
    @players.each_with_index do |player, index|
      frames = player.frames
      rows << [player.name, '', '', '', '', '', '', '', '', '', ' ']
      rows << ['Pinfalls',
                format_bowl(frames[0].bowls),
                format_bowl(frames[1].bowls),
                format_bowl(frames[2].bowls),
                format_bowl(frames[3].bowls),
                format_bowl(frames[4].bowls),
                format_bowl(frames[5].bowls),
                format_bowl(frames[6].bowls),
                format_bowl(frames[7].bowls),
                format_bowl(frames[8].bowls),
                format_bowl(frames[9].bowls),
             ]
      rows << ['Score',
              frames[0].accumulated_score.to_s,
              frames[1].accumulated_score.to_s,
              frames[2].accumulated_score.to_s,
              frames[3].accumulated_score.to_s,
              frames[4].accumulated_score.to_s,
              frames[5].accumulated_score.to_s,
              frames[6].accumulated_score.to_s,
              frames[7].accumulated_score.to_s,
              frames[8].accumulated_score.to_s,
              frames[9].accumulated_score.to_s,
            ]

      rows << ['', '', '', '', '', '', '', '', '', '', ' '] unless index == @players.count-1
    end

    @table = Terminal::Table.new do |t|
      t.headings = heading
      t.rows = rows
      t.title = "Bowling Score"
    end
    puts @table
  end

  def format_bowl(bowl)
    if bowl.size == 1
      '    X'
    elsif bowl.size == 2 && bowl.sum == 10
      " #{bowl[0]}  /"
    elsif bowl.size == 2
      " #{bowl[0]}  #{bowl[1]}"
    else
      "#{bowl[0]} #{bowl[1]} #{bowl[2]}"
    end
  end
end