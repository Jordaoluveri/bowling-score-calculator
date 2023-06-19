# Bowling Score Calculator

This Ruby app takes a file with simulated bowling tries, calculates the score for each player and prints a formatted scoreboard in the command line with the apropriate score for the game.

## How to run
Clone this repo and assuming you already have ruby installed run:

    bundle install
and then you can run the program with

    ruby lib/bowling_score_calculator.rb lib/`file`

where `file` can be:
`perfect.txt`
`all-foul.txt`
`scores.txt`
`several-players.txt`

The files with invalid data, format or empty will return an error with the appropriate messaging telling you what is wrong with the file. They can be:
`empty.txt`
`extra-score.txt`
`free-text.txt`
`invalid-score.txt`
`negative.txt`


## Testing

        bundle exec rspec