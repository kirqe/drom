require_relative "drom/version"
require_relative 'drom/client'
require_relative 'drom/search'
require_relative 'drom/listing'

module Drom
  def self.search(options, &block)
    Drom::Search.new(options, &block)
  end

  def self.get_single_listing(url)
    page = Client.get(url)
    Drom::Listing.new(page).parsed
  end
end
