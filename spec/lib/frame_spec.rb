require 'spec_helper'
require 'frame'

RSpec.describe Frame do
  context 'Happy path' do
    let(:frame) { Frame.new }

    context 'creating a frame' do
      it 'has 10 pins left' do
        expect(frame.pins_left).to eq 10
      end

      it 'has 0 points' do
        expect(frame.points).to eq 0
      end

      it 'has 0 accumulated_score' do
        expect(frame.accumulated_score).to eq 0
      end

      it 'has 0 bowl attempts' do
        expect(frame.bowls).to be_an(Array)
        expect(frame.bowls.size).to eq 0
      end
    end

    context 'adding a bowl try' do
      it "adds the pinfall to the bowl array" do
        pinfall = 1
        frame.add_bowl(pinfall)

        expect(frame.bowls).to include pinfall
      end
    end

    context 'adding a strike' do
      it "finishes the frame" do
        pinfall = 10
        frame.add_bowl(pinfall)

        expect(frame.finished?).to eq true
        expect(frame.pins_left).to eq 0
      end
    end

    context 'adding a spare' do
      it "finishes the frame and have no pins left" do
        frame.add_bowl(3)
        frame.add_bowl(7)

        expect(frame.finished?).to eq true
        expect(frame.pins_left).to eq 0
      end
    end
  end

  context 'Validations' do
    let(:frame) { Frame.new }

    it 'cant have negative bowl try' do
      expect{frame.add_bowl(-1)}.to raise_error(RuntimeError).with_message("Invalid pin number")
    end

    it 'cant have more than 10 pinfalls' do
      expect{frame.add_bowl(11) }.to raise_error(RuntimeError).with_message("Invalid pin number")
    end

    it 'cant have more than 2 bowl tries' do
      2.times { frame.add_bowl(0) }

      expect{frame.add_bowl(0)}.to raise_error(RuntimeError).with_message("Frame is finished")
    end
  end
end
