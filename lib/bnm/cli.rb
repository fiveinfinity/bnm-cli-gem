class Cli # How many responsibilities?
  # 1. Controller Logic
  # 2. SToring Data - artists
  # 3. scraping
  attr_accessor :artists
  @@url = "http://pitchfork.com/reviews/best/albums/?page=1"

  def initialize
    @artists = Array.new
  end

  ################FIRST METHOD TO RUN######################
  def call
    #url
    init_scrape(@@url)
    # deep_scrape
    ui
  end

############### CLI INTERFACE #############################
  def ui
    puts "-----------------------------------------------"
    puts "WELCOME TO PITCHFORK'S 'BEST NEW MUSIC' TOP 24."
    puts "LIST IS SORTED BY BNM's ARTIST & ALBUM."
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
  ## 3-16-16: BNM HAS A NEW PAGE, NOW 24 ARTISTS PER PAGE.#

    # def url
    #   next_page = (2..5).to_a
    #   init_scrape(@@url)
    #
    #   next_page.each do |i|
    #     if i == 2
    #       @@url += "/#{i}/"
    #       init_scrape(@@url)
    #     else
    #       @@url.slice! "/#{i-1}/"
    #       @@url += "/#{i}/"
    #       init_scrape(@@url)
    #     end
    #   end
    # end

#######################SCRAPES URL#########################
  def init_scrape(url)
    doc = Nokogiri::HTML(open(url))
    #html = doc.css("ul.object-list.bnm-list li")
    html = doc.css("div.review")

    html.each do |i|
      review_url = i.css("a").attribute("href").text
      name = i.css("ul.artist-list li").text
      album = i.css("h2.title").text

      @artists << Artist.new(name, album, rating_url) if !name.empty?  && !album.empty?
      #score: i.css("div.info span.score.bnm").text.gsub(/\s+/, ""), editorial: i.css("div.editorial p").text
    end

    # @artists.each do |i|
    #   i.each do |k, v|
    #     @artists.delete(i) if v == ""
    #   end
    # end
    # @artists.sort! {|a, b| b[:score] <=> a[:score]}
    @artists
  end


  # def deep_scrape
  #   @artists.each do |i|
  #     doc = Nokogiri::HTML(open("http://pitchfork.com#{i[:review_url]}"))
  #     @artists[i][:score] = doc.css("div.score-box.bnm span.score").text
  #     @artists[i][:editorial] = doc.css("div.article-content p").text
  #   end
  # end

#####################DISPLAYS ARTIST UPON GEM LAUNCH######
  def display_artist
    counter = 1
    @artists.each do |artist|
      display = "#{i[:name]}, #{i[:album]}"
      printf("%2d. %5s\n", counter, display)
      counter += 1
    end
  end

#################DISPLAYS ARTIST PAGE####################
  def artist_page(index)
    a = @artists[index]
    puts("ARTIST: #{a[:name]}  ALBUM: #{a[index][:album]}  SCORE: #{@artists[index][:score]}")
    puts "#{@artists[index][:editorial]}"
    puts "-------------------------------"
    puts "Would you liek to see this in a browser"
    a.open
  end
end

class Artist
   def open
     system("open '#{a[:rating_url]}'")
   end
 end
