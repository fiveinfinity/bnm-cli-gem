module Bnm::CLI
############## INIT. INTERFACE #############################
  def self.launch(artists)
    puts "---------------------------------------------------------------"
    puts "    WELCOME TO PITCHFORK'S 'BEST NEW MUSIC' SORTED BY SCORE.   "
    puts "         SELECT AN ARTIST BY NUMBER. NOW WITH APPLE MUSIC      "
    puts "---------------------------------------------------------------"
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
    puts "---------------------------------------------------------------------"
    puts "1 for Apple Music"
    puts "2 for article"
    puts "3 for Amoeba Music"
    puts "4 to re-list"
    puts "5 to exit"
    input = gets.chomp

    if input == '1' && !artists[index][:itunes].nil?
      system('open', artists[index][:itunes])
      puts '########################################################'
      artist_page(input, index, artists)
    elsif input == '1' && artists[index][:itunes].nil?
      puts '########################################################'
      puts 'There is no link available. Please choose another option'
      puts '########################################################'
      artist_page(input, index, artists)
    elsif input == '2'
       puts "#{artists[index][:editorial]}"
       puts '########################################################'
       artist_page(input, index, artists)
     elsif input == '3' && !url.nil?
        system('open', url)
        puts '########################################################'
        artist_page(input, index, artists)
      elsif input == '3' && url.nil?
        puts '########################################################'
        puts 'There is no link available. Please choose another option'
        puts '########################################################'
        artist_page(input, index, artists)
      elsif input == '4'
        launch(artists)
      elsif input == '5'
        exit
    end
  end
end
