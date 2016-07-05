require 'nokogiri'
require 'htmlentities'
require 'open-uri'
require 'pry'

module Bnm::Scrape
#######################SCRAPES URL#########################
  def self.init_scrape(url)
    artists = []
    doc = Nokogiri::HTML(open(url))
    html = doc.css("div.review")

    html.each do |i|
      artists << {
        review_url: i.css("a").attribute("href").text,
        name: scrub(i.css('.artist-list li').text),
        album: scrub(i.css('.album-artist .title').text),
        date: i.css('.meta .pub-date').text
      }
    end

    # IF SCRAPE COMES UP EMPTY
    artists.each do |i|
      i.each do |k, v|
        artists.delete(i) if v == ""
      end
    end
    artists
  end

#####################SCRAPES ARTISTS STORY AND SCORE######
  def self.deep_scrape(artists)
    artists.each do |artist|
      doc = Nokogiri::HTML(open("http://pitchfork.com#{artist[:review_url]}"))
      html = doc.css('div.review-detail')

      html.each do |i|
        editorial = scrub(HTMLEntities.new.decode(i.css('div.article-content').text))
        author = scrub(i.css('a.display-name').text)
        score = i.css('span.score').text

        # CHECKS THAT URI IS NOT NIL
        if !(i.css('.find-it-at a')).empty?
          listen = i.css('.find-it-at a').attribute('href').text
        end

        # NOT EVERY ARTIST HAS THE SAME INFORMATION, SOME ATTRIUBUTES ARE EMPTY, HENCE THE CONDITIONAL
        artist[:editorial] = (editorial) if !editorial.empty?
        artist[:score] = (score) if !score.empty?
        artist[:listen] = (listen) if listen
        artist[:author] = (author) if !author.empty?

        # FINDS GENRES FOR ARTIST - SOME HAVE MORE THAN ONE GENRE.
        i.css('ul.genre-list').each do |i|
          artist[:genres] = scrub(i.css('a').text)
        end
      end
    end
    artists.sort! {|a, b| b[:score] <=> a[:score]}
  end

#####################SCRUBS DATA#########################
  def self.scrub(data)
    ### REMOVES AMOEBA LINK FROM ARTICLE
    if data.include? 'Find it at:Amoeba Music'
      data.slice! 'Find it at:Amoeba Music'
    end
    ### REPLACING UTF-8 ARTIFACTS
    data.gsub!(/â/, "'")
    data.gsub!(/Â/, "")
    data.gsub!(/Ã©/, "é")
    data
  end
end
