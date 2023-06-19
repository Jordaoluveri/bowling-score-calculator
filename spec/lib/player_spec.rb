require 'spec_helper'
require 'player'

RSpec.describe Player do
  context 'Happy path' do
    let(:player_name) { "Carl" }
    let(:player_pinfalls) { Array.new(12, 10) }
    let(:player) { Player.new(player_name, player_pinfalls) }

    context 'creating a player' do
      it 'have 10 frames' do
        expect(player.frames.length).to eq 10
      end

      it 'have a name' do
        expect(player.name).to eq player_name
      end

      it 'have a total score equal to frames accumulated score' do
        expect(player.current_frame.accumulated_score).to eq player.total_score
      end
    end
  end

  context 'Validations' do
    let(:invalid_name) { "" }
    let(:name) { "John" }
    let(:invalid_pinfalls) { Array.new(99, 10) }
    let(:pinfalls) { Array.new(20, 0) }

    it 'return an error trying to create a player with an empty name' do
      expect{ Player.new(invalid_name, pinfalls) }.to raise_error(RuntimeError).with_message("Player cant have an empty name")
    end

    it 'returns an error trying to create a player with invalid pinfall tries' do
      expect{ Player.new(name, invalid_pinfalls) }.to raise_error(RuntimeError).with_message("Wrong number of pinfalls for player: '#{name}'")
    end

    it 'cant add a frame manually' do
      player = Player.new(name, pinfalls)

      expect{player.frame << Frame.new}.to raise_error(NoMethodError)
    end
  end
end
