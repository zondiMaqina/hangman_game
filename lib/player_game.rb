require_relative 'game_data/game_track'
require 'colorize'
require 'json'
# class for starting the game for player
class PlayerGame < GameTrack
  def initialize
    @json_path = File.join(__dir__, './game_data/player_game.json') # The path to file
    @a = Artii::Base.new
    start_game
  end

  private

  def start_game # introduces player to game
    tries = JSON.parse(File.read(@json_path))['player_tries']
    intro = ["You have #{tries} tries to guess the word chosen by me :)".colorize(:yellow), 'GOOD LUCK'.colorize(:green).bold]
    intro.each do |line|
      sleep(1)
      puts(line)
    end
    if tries > 0
      chosen_word
    else
      game_over
    end
    play
  end

  def chosen_word # Shows the chosen word that the player has guessed each time
    word = JSON.parse(File.read(@json_path))['player_guess']
    puts "The chosen word is ------------> #{word}"
    sleep(1)
    puts 'Guess by letters each time or guess the whole word to win quicker !!!'
  end

  def play
    self.player_tries # decraeses the amount of tries player has and updates json file
    tries = JSON.parse(File.read(@json_path))['player_tries']
    check_tries(tries)
    if tries <= 0
      self.reset_game
      game_over
    end
    while tries > -2
      play_game(gets.chomp) # lets player take guess each time
      check_win(JSON.parse(File.read(@json_path))['random_word'])
      self.player_tries # decraeses the amount of tries player has and updates json file
    end
  end

  def play_game(player_guess)
    chosen_word = JSON.parse(File.read(@json_path))['random_word']
    tries = JSON.parse(File.read(@json_path))['player_tries']
    guess = player_guess.gsub(' ', '')
    check_tries(tries)
    if player_guess.empty?
      puts 'Empty space is invalid mate'.colorize(:red)
      puts "You have #{tries} tries left".colorize(:yellow)
    elsif guess == chosen_word
      player_wins
    elsif chosen_word.include?(guess)
      show_name_completion(player_guess)
      puts "You have #{tries} tries left".colorize(:yellow)
    else
      puts "#{player_guess} does not exist in chosen word :(".colorize(:red)
      puts "You have #{tries} tries left".colorize(:yellow)
    end
  end

  def show_name_completion(player_guess) # shows the letters the player guesses each time
    guess = player_guess[0].downcase
    chosen_word = JSON.parse(File.read(@json_path))['random_word']
    if chosen_word.include?(guess)
      feth_letter_index(guess)
    else
      puts JSON.parse(File.read(@json_path))['random_word']
    end
  end

  def feth_letter_index(guess)
    nums = [] # stores the index of letters guessed in word
    letters = JSON.parse(File.read(@json_path))['random_word'].split('')
    letters.each_with_index do |letter, index|
      if letter == guess
        nums << index
      else
        index
      end
    end
    replace_letter(nums, guess) # changes the blank word with correct guessed letters
  end

  def replace_letter(nums, letter)
    word_completion = JSON.parse(File.read(@json_path))['player_guess'].split('')
    nums.each do |num|
      word_completion[num] = letter
    end
    self.track_word_completion(word_completion)
  end

  def player_wins
    puts "CORRECT !!! the word was #{JSON.parse(File.read(@json_path))['random_word']}".colorize(:green)
    sleep(1)
    puts @a.asciify('YOU WIN !!!').colorize(:green).bold
    self.reset_game
    exit
  end

  def check_win(chosen_word)
    player_guess = JSON.parse(File.read(@json_path))['player_guess']
    if chosen_word == player_guess
      player_wins
    end
  end

  def check_tries(tries)
    game_over if tries <= -1
  end

  def game_over
    self.reset_game
    puts 'Game Over YOU LOSE :('.colorize(:red)
    exit
  end
end

# Show the chosen word as blanks on screen