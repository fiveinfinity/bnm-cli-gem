require 'thread'

class Bnm::Init
  attr_accessor :artists
  @@url = "http://pitchfork.com/reviews/best/albums/"

  def initialize
    @artists = Array.new
  end

  def call

    # INITIATES SPINNER
    thr = Thread.new do
      while true
        Bnm::Spinner.loading
      end
    end

    # SCRAPING URIS AND ARTISTS
    @artists = Bnm::Scrape.init_scrape(@@url)
    Bnm::Scrape.deep_scrape(@artists)
    Bnm::API.itunes(@artists)

    # KILLS SPINNER AND CLEARS FROM SCREEN
    Thread.kill(thr)
    print "\r"

    # PRINTS OUT DYNAMIC CLI
    Bnm::CLI.launch(@artists)
  end
end
