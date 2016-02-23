require 'nokogiri'
require 'open-uri'
require 'pry'

class Bnm::CLI
  attr_accessor :artists
  @@url = "http://pitchfork.com/reviews/best/albums"

  def initialize
    @artists = Array.new
  end

  ################FIRST METHOD TO RUN######################
  def call
    url
    ui
  end

############### CLI INTERFACE #############################
  def ui
    puts "-----------------------------------------------"
    puts "WELCOME TO PITCHFORK'S 'BEST NEW MUSIC' TOP 25."
    puts "LIST IS SORTED BY HIGHEST SCORE, ARTIST, ALBUM."
    puts "SELECT AN ARTIST BY NUMBER FOR MORE INFORMATION."
    puts "-----------------------------------------------"
    display_artist
    input = gets.chomp.to_i
    artist_page(input-1)
    puts "Would you like to exit, or re-list 'Best New Music'?"
    puts "(please type 'exit' or 'list')"
    input = gets.chomp

    if input == 'list'
      ui
    elsif input == 'list'
      exit
    end
  end

  #############COULD BREAK IF DIRECTORY CHANGES############
  #############ITERATES OVER URL'S TO SCRAPE###############
    def url
      next_page = (2..5).to_a
      init_scrape(@@url)

      next_page.each do |i|
        if i == 2
          @@url += "/#{i}/"
          init_scrape(@@url)
        else
          @@url.slice! "/#{i-1}/"
          @@url += "/#{i}/"
          init_scrape(@@url)
        end
      end
    end

#######################SCRAPES URL#########################
  def init_scrape(url)
    doc = Nokogiri::HTML(open(url))
    html = doc.css("ul.object-list.bnm-list li")

    html.each do |i|
      @artists << {review_url: i.css("a").attribute("href").text, name: i.css("div.info h1").text, album: i.css("div.info h2").text, score: i.css("div.info span.score.bnm").text.gsub(/\s+/, ""), editorial: i.css("div.editorial p").text}
    end

    @artists.each do |i|
      i.each do |k, v|
        @artists.delete(i) if v == ""
      end
    end
    @artists.sort! {|a, b| b[:score] <=> a[:score]}
    @artists
  end

#####################DISPLAYS ARTIST UPON GEM LAUNCH######
  def display_artist
    counter = 1
    @artists.each do |i|
      display = " #{i[:score]}  #{i[:name]}, #{i[:album]}"
      printf("%2d. %5s\n", counter, display)
      counter += 1
    end
  end

#################DISPLAYS ARTIST PAGE####################
  def artist_page(index)
    @artists[index]
    puts("ARTIST: #{@artists[index][:name]}  ALBUM: #{@artists[index][:album]}  SCORE: #{@artists[index][:score]}")
    puts "#{@artists[index][:editorial]}"
    puts "-------------------------------"
  end
end
