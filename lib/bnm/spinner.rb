require 'colorize'

module Bnm::Spinner
  ASCII = ['⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷']
  def self.loading
    ASCII.each do |ascii|
      print "\rLoading artists... #{ascii} ".yellow
      sleep 0.2
    end
  end
end
