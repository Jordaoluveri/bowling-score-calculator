require 'spec_helper'
require 'open3'
require 'bowling_score_calculator'

RSpec.describe BowlingScoreCalculator do
  let(:perfect)  { file_fixture('perfect.txt') }
  let(:several_players)  { file_fixture('several-players.txt') }
  let(:scores)   { file_fixture('scores.txt')}
  let(:all_foul) { file_fixture('all-foul.txt')}
  let(:free_text) { file_fixture('free-text.txt')}
  let(:empty) { file_fixture('empty.txt')}
  let(:invalid_score) { file_fixture('invalid-score.txt')}
  let(:extra_score) { file_fixture('extra-score.txt')}


  let(:exec) { File.expand_path('../../lib/bowling_score_calculator.rb', File.dirname(__FILE__)) }

  context 'when input file is valid' do

    context 'with more than two players' do
      it 'prints the game scoreboard to stdout' do
        res = `ruby #{exec} #{several_players}`

        expect(res).to include("John")
        expect(res).to include("Jeff")
        expect(res).to include("Carl")
        expect(res).to include("Robert")
        expect(res).to include("Simon")
        expect(res).to include("Jack")
      end
    end

    context 'with strikes in all throwings' do
      it 'prints a perfect game scoreboard' do
        res = `ruby #{exec} #{perfect}`

        expect(res).to include("30")
        expect(res).to include("60")
        expect(res).to include("90")
        expect(res).to include("120")
        expect(res).to include("150")
        expect(res).to include("180")
        expect(res).to include("210")
        expect(res).to include("240")
        expect(res).to include("270")
        expect(res).to include("300")
      end
    end

    context 'with fouls in all throwings' do
      it 'prints the game scoreboard to stdout' do
        res = `ruby #{exec} #{all_foul}`

        expect(res).to include("0").at_least(31).times # Two "0" from each frame, Ten frames = 20.
                                                       # One "0" from each score = 10, Ten Scores.
                                                       # One "0" from the number ten on the header = 1.
                                                       # 20+10+1 = 31
      end
    end
  end

  context 'when input file is invalid' do
    context 'with invalid characters present' do
      it 'raises the corresponding error message' do
        res_string = "ruby #{exec} #{free_text}"

        Open3.popen3(res_string) do |_stdin, _stdout, stderr|
          expect(stderr.read).to include('File in wrong format')
        end
      end
    end

    context 'with empty file' do
      it 'raises the corresponding error message' do
        res_string = "ruby #{exec} #{empty}"

        Open3.popen3(res_string) do |_stdin, _stdout, stderr|
          expect(stderr.read).to include('File is empty')
        end
      end
    end

    context 'with invalid score' do
      it 'raises the corresponding error message' do
        res_string = "ruby #{exec} #{invalid_score}"

        Open3.popen3(res_string) do |_stdin, _stdout, stderr|
          expect(stderr.read).to include("File doesnt contain valid pin throw in line:")
        end
      end
    end

    context 'with invalid number of throwings' do
      it 'raises the corresponding error message' do
        res_string = "ruby #{exec} #{extra_score}"

        Open3.popen3(res_string) do |_stdin, _stdout, stderr|
          expect(stderr.read).to include("Wrong number of pinfalls for player:")
        end
      end
    end
  end
end
