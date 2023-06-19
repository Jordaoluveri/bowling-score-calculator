module FileParser
  PINS_REGEX = /\b(^[0-9]|10|F$)\b/

  extend self

  def call(file)
    raise 'File is empty' if File.zero?(file)

    # validates if every line of the file corresponds to the expected results (|name|whitespace|number|)
    File.open(file).each do |line|
      splitted_line = line.split(' ')

      raise 'File in wrong format' if splitted_line.size > 2
      raise "File doesnt contain valid pin throw in line: '#{line.gsub(/\n/, '')}'" if !is_valid_pin_throw?(splitted_line[1])
    end

    get_players(file)
  end

  def get_players(file)
    players = {}
    File.open(file).each do |line|
      name, number = line.split(' ')

      if players[name].nil?
        players[name] = [number]  # Initialize player key with pinfall
      else
        players[name].push number # Add throw to player key
      end
    end
    players
  end

  def is_valid_pin_throw?(str)
    str =~ PINS_REGEX
  end
end