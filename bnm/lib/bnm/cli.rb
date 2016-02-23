require 'nokogiri'
require 'open-uri'
require 'pry'

class Bnm::CLI

  attr_accessor :artists
  @@url = "http://pitchfork.com/reviews/best/albums/"

  def initialize
    @artists = Array.new
  end


  def call
    artist_list(@@url)
    url
    select_artist
  end

  def artist_list(url)
    doc = Nokogiri::HTML(open(url))
    html = doc.css("ul.object-list.bnm-list li")

    html.each do |i|
      @artists << {name: i.css("div.info h1").text, album: i.css("div.info h2").text, score: i.css("div.info span.score.bnm").text.gsub(/\s+/, ""), editorial: i.css("div.editorial p").text}
    end

    @artists.each do |i|
      i.each do |k, v|
        @artists.delete(i) if v == ""
      end
    end
    @artists
  end

########################COULD BREAK IF DIRECTORY CHANGES###############################
########################CHILD METHOD OF #artist_list###############################
  def url
    next_page = (2..10).to_a

    next_page.each do |i|
      if i == 2
        @@url += "#{i}/"
        artist_list(@@url)
      else
        @@url.slice! "#{i-1}/"
        @@url += "#{i}/"
        artist_list(@@url)
      end
    end
  end

  def select_artist
    puts 'which artist would you like to check out?'
    binding.pry
    input = gets.strip
  end
end
