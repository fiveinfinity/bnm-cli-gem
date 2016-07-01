class Bnm::Init
  attr_accessor :artists
  @@url = "http://pitchfork.com/reviews/best/albums/"

  def initialize
    @artists = Array.new
  end

  ################FIRST METHOD TO RUN######################
  def call
    @artists = Bnm::Scrape.init_scrape(@@url)
    Bnm::Scrape.deep_scrape(@artists)
    Bnm::CLI.launch(@artists)
  end
end
