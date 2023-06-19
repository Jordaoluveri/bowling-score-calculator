require 'spec_helper'
require 'scorekeeper'

RSpec.describe Scorekeeper do
  context 'Happy path' do
    let(:name_1) { "Carl" }
    let(:name_2) { "John" }
    let(:name_3) { "Simon" }
    let(:perfect_pinfalls) { Array.new(12, 10) }
    let(:worst_pinfalls) { Array.new(20, 0) }
    let(:sample_pinfalls) { [10,7,3,9,0,10,0,8,8,2,"F",6,10,10,10,8,1] }
    let(:player_1) { Player.new(name_1, perfect_pinfalls) }
    let(:player_2) { Player.new(name_2, worst_pinfalls) }
    let(:player_3) { Player.new(name_3, sample_pinfalls) }

    context 'creating a scoreboard' do
      it 'returns the correct score for a player' do
        expect(Scorekeeper.new(player_1.frames).total).to eq 300 # Perfect Score
        expect(Scorekeeper.new(player_2.frames).total).to eq 0 # All foul Score
        expect(Scorekeeper.new(player_3.frames).total).to eq 167 # All foul Score
      end
    end
  end
end
