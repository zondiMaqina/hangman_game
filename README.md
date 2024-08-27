# HANGMAN

# Rules to Game

> [!NOTE]
> In order to be able to play game please do understand the rules and install all dependencies needed (Bundler)

- You will be playing against the computor (host => chooses a secret word)
- The host (which is the computor) will pick a *secret word*
- You will have 7 tries for each word to try and guess each letter of word
- Within those 7 tries, the computor will draw a full hangman figure from *7 shapes*
- If you guess the word or the letters correctly before the computor is done drawing, *YOU WIN*

## DEVELOPMENT DETAILS

-  My first program (game) that saves the progress of the games you play using files manipulation
-  It will save each new game in a new file

## FEATURES IN GAME

### Player features
1. Each game can be saved in a diferent file
2. You can delete each game or continue from it

### Computer features
1. Draw 7 shapes

- line (5)
- circle (1)
- rectangle (1)

## CHALLENGES & SOLUTIONS

- [ ] How to save progress of one game using a file
- [ ] How to delete a saved game
- [ ] How to save game by command
- [ ] How to draw in a terminal
- [ ] Gem for making text bold in terminal

### Solutions

- [x] For making text bold in terminal use the `colorize` gem with the `#bold` method
- [x] For showing shapes in terminal use the `artii` gem or `ruby2d` gem
- [x] To save progress in each game we use JSON string formatiing for stored information in hash
- [x] To make text bold in terminal we use the `bold` method from the gem `colorize`
- [x] To draw in terminal we use the `ruby2d` gem which shows the graphics externally