require 'colorize'
require 'artii'
require_relative 'lib/player_game'

# Class intiation that starts the game
class StartGame
  def initialize
    @a = Artii::Base.new
    puts @a.asciify('HANGMAN').colorize(:green) # Shows logo of game
    sleep(1)
    introduce_player
  end

  private

  def introduce_player
    puts 'Hello there player!!!  Time to play Hangman :)'.colorize(:yellow).bold
    show_options
  end

  def show_options
    options = ['Play Game', 'Exit Game']
    options.each_with_index do |option, index| # displays the options for player to choose
      sleep(1)
      puts "#{index + 1} #{option}".colorize(:blue)
    end
    execute_option(gets.chomp) # executes the option chosen
  end

  def execute_option(chosen_option)
    until chosen_option.gsub(' ', '') == '1' || chosen_option.gsub(' ', '') == '2'
      puts 'Please enter a valid option of [1] or [2]'.colorize(:red)
      chosen_option = gets.chomp
    end
    start_game(chosen_option)
  end

  def start_game(chosen_option)
    if chosen_option == '1'
      PlayerGame.new
    else
      puts 'Thanks for playing HANGMAN :)'
      puts 'Game Over'.bold.colorize(:red)
      exit
    end
  end
end

StartGame.new # => Starts the Game
