require_relative "drom/version"
require_relative 'drom/client'
require_relative 'drom/search'
require_relative 'drom/page'
require_relative 'drom/listing_parser'

module Drom
  def self.search(options, &block)
    Drom::Search.new(options, &block)
  end

  def self.get_single_listing(url)
    @client = Client.new
    page = @client.get(url)
    Drom::ListingParser.new(url, page).parsed
  end
end

require 'whirly'
