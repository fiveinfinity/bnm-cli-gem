require 'faraday'
require 'JSON'

module Bnm::API
  def self.itunes(artists)
    artists.map do |artist|
      artist_response = artist_api_call(artist)
    end
  end


  def self.artist_api_call(artist)
    slugged_name = artist[:name].split(' ').join('+')
    artist_response = Faraday.get "http://itunes.apple.com/search?term=#{slugged_name}"
    artist_json = JSON.parse(artist_response.body)
    response = self.results(artist, artist_json)
    if response
      self.album_api_call(artist, response['collectionId'])
    end
  end

  def self.results(artist, res)
    response = res['results']
    if response.length > 0
      response.find {|item| item['collectionName'] == artist[:album] && item['artistName'] == artist[:name]}
    end
  end

  def self.album_api_call(artist, album)
    album_response = Faraday.get "http://itunes.apple.com/lookup?id=#{album}&entity=album&attribute=albumTerm"
    album_json = JSON.parse(album_response.body)
    artist[:itunes] = results(artist, album_json)['collectionViewUrl']
  end
end
