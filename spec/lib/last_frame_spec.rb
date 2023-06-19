require 'spec_helper'
require 'last_frame'

RSpec.describe LastFrame do
  context 'Happy path' do
    let(:last_frame) { LastFrame.new }

    context 'adding a strike' do
      it "doesn't finish the frame and allow 2 extra rolls" do
        pinfall = 10
        last_frame.add_bowl(pinfall)

        expect(last_frame.finished?).to eq false
        expect(last_frame.pins_left).to eq 0
        expect(last_frame.extra_rolls).to eq 2
      end
    end

    context 'adding a spare' do
      it "doesn't finishes the frame and an extra roll" do
        last_frame.add_bowl(3)
        last_frame.add_bowl(7)

        expect(last_frame.finished?).to eq false
        expect(last_frame.pins_left).to eq 0
        expect(last_frame.extra_rolls).to eq 1
      end
    end

    context 'when it has an extra roll' do
      it 'allows for a bowl to have 3 tries and finishes the frame' do
        3.times { last_frame.add_bowl(10) }

        expect(last_frame.bowls.length).to eq 3
        expect(last_frame.finished?).to eq true
      end
    end
  end

  context 'Validations' do
    let(:last_frame) { LastFrame.new }

    context 'extra rolls' do
      before do
        2.times { last_frame.add_bowl(0) }
      end

      it 'cant have more than 2 bowl tries without extra rolls' do
        expect(last_frame.extra_rolls).to eq 0
      end

      it "finishes the frame without extra rolls" do
        expect(last_frame.finished?).to eq true
      end

      it "returns an error if we try to add one more roll" do
        expect{ last_frame.add_bowl(0) }.to raise_error(RuntimeError)
      end
    end
  end
end
