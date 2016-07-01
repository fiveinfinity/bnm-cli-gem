module Bnm::CLI
############## INIT. INTERFACE #############################
  def self.launch(artists)
    puts "-----------------------------------------------"
    puts "    WELCOME TO PITCHFORK'S 'BEST NEW MUSIC'    "
    puts "       LIST IS SORTED BY HIGHEST SCORE.        "
    puts "         SELECT AN ARTIST BY NUMBER.           "
    puts "-----------------------------------------------"
    display_artist(artists)
    input = gets.chomp.to_i
    index = input - 1

    artist_page(input, index, artists)
  end

#####################DISPLAYS ARTIST UPON GEM LAUNCH######
  def self.display_artist(artists)
    counter = 1
    artists.each do |i|
      display = " #{i[:score]}  #{i[:name]}, #{i[:album]}"
      printf("%2d. %5s\n", counter, display)
      counter += 1
    end
    puts "-----------------------------------------------"
    puts 'Please chose an artist by typing the number'
    puts "-----------------------------------------------"
  end

#################DISPLAYS ARTIST PAGE####################
  def self.artist_page(input, index, artists)
    url = artists[index][:listen]

    puts("ARTIST: #{artists[index][:name]}  ALBUM: #{artists[index][:album]}  SCORE: #{artists[index][:score]}")
    puts "-------------------------------"
    puts "Would you like to see the article, listen, re-list, or exit 'Best New Music'?"
    puts "(please type '1' for article, '2' to listen, '3' to re-list artists, or '4' to exit)"
    input = gets.chomp

    if input == '1'
      puts "#{artists[index][:editorial]}"
      puts '########################################################'
      artist_page(input, index, artists)
    elsif input == '2' && !url.nil?
      Launchy.open("#{url}")
      puts '########################################################'
      artist_page(input, index, artists)
    elsif input == '2' && url.nil?
      puts '########################################################'
      puts 'There is no link available. Please choose another option'
      puts '########################################################'
      artist_page(input, index, artists)
    elsif input == '3'
      launch(artists)
    elsif input == '4'
      exit
    end
  end
end
