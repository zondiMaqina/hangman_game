require 'json'
class GameTrack # module for tracking and updating json file
  def reset_game # starts a new game
    @chosen_word = fetch_word
    @tries = 8
    @guess_completion = @chosen_word.gsub(/[a-zA-Z]/, '_')
    @player_game = {random_word: @chosen_word, player_tries: @tries, player_guess: @guess_completion}
    ser_new_player_data(@player_game)
  end

  def ser_new_player_data(game) # transfers new data to json file
    path = File.join(__dir__, './player_game.json')
    File.open(path, 'w') do |file|
      file.write(game.to_json)
    end
  end

  def check_player_data # returns data from json file
    path = File.join(__dir__, './player_game.json')
    data = JSON.parse(File.read(path))
    data
  end

  def fetch_word # takes random word from google file that meets condtions
    path = File.join(__dir__, '../google-10000-english-no-swears.txt')
    words = File.readlines(path)
    chosen_words_from_file = []
    while chosen_words_from_file.length < 1000
      words.each { |word| chosen_words_from_file << word if word.length > 5 && word.length <= 7 }
    end
    random_word = chosen_words_from_file.sample.chomp
    random_word
  end

  def player_tries # decreases player tries and updates json file
    path = File.join(__dir__, './player_game.json')
    data = JSON.parse(File.read(path))
    data['player_tries'] = (data['player_tries'] - 1)
    File.write(path, data.to_json)
  end

  def track_word_completion(word)
    json_path = File.join(__dir__, './player_game.json')
    hash = JSON.parse(File.read(json_path))
    hash['player_guess'] = word.join('')
    File.write(json_path, hash.to_json)
    puts JSON.parse(File.read(json_path))['player_guess']
  end
end
