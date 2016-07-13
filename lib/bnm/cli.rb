require 'colorize'

module Bnm::CLI
############## INIT. INTERFACE #############################
  def self.launch(artists)
    puts "---------------------------------------------------------------".yellow
    puts "    WELCOME TO PITCHFORK'S 'BEST NEW MUSIC' SORTED BY SCORE.   "
    puts "         SELECT AN ARTIST BY NUMBER. NOW WITH APPLE MUSIC      "
    puts "                  OR PRESS ANY LETTER TO EXIT                  "
    puts "---------------------------------------------------------------".yellow
    display_artist(artists)

    input = Integer(gets.chomp) rescue nil

    if input == nil
      exit
    elsif input < 1 || input > 24
      puts '###############################################'.yellow
      puts 'THAT IS NOT A VALID CHOICE, PLEASE CHOOSE AGAIN'.red
      puts '###############################################'.yellow
      launch(artists)
    else
      index = input - 1
      artist_page(input, index, artists)
    end
  end

#####################DISPLAYS ARTIST UPON GEM LAUNCH######
  def self.display_artist(artists)
    counter = 1
    artists.each do |i|
      display = Array.new
      display.push(" #{i[:score]}".red)
      display.push(" #{i[:name]}".yellow)
      display.push(" #{i[:album]}".green)
      printf("%2d. %5s\n", counter, display.join(''))
      counter += 1
    end
    puts "--------------------------------".yellow
    puts 'Please chose an artist by number'
    puts "--------------------------------".yellow
  end

#################DISPLAYS ARTIST PAGE####################
  def self.artist_page(input, index, artists)
    url = artists[index][:listen]
    artist = Array.new
    artist.push(" #{artists[index][:score]}".red)
    artist.push(" #{artists[index][:name]}".yellow)
    artist.push(" #{artists[index][:album]}".green)

    puts artist.join('')
    puts "--------------------------------------------------------".yellow
    puts "1 for Apple Music"
    puts "2 for article"
    puts "3 for Amoeba Music"
    puts "4 to re-list"
    puts "5 to exit"
    input = gets.chomp

    if input == '1' && !artists[index][:itunes].nil?
      system('open', artists[index][:itunes])
      puts '########################################################'.yellow
      artist_page(input, index, artists)
    elsif input == '1' && artists[index][:itunes].nil?
      puts '########################################################'.yellow
      puts 'There is no link available. Please choose another option'.red
      puts '########################################################'.yellow
      artist_page(input, index, artists)
    elsif input == '2'
       puts "#{artists[index][:editorial]}"
       puts '########################################################'.yellow
       artist_page(input, index, artists)
     elsif input == '3' && !url.nil?
        system('open', url)
        puts '########################################################'.yellow
        artist_page(input, index, artists)
      elsif input == '3' && url.nil?
        puts '########################################################'.yellow
        puts 'There is no link available. Please choose another option'.red
        puts '########################################################'.yellow
        artist_page(input, index, artists)
      elsif input == '4'
        launch(artists)
      elsif input == '5'
        exit
      else
        launch(artists)
    end
  end
end
