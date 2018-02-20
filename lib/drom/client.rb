require 'httparty'
require 'nokogiri'

module Drom
  class Client
    include HTTParty
    base_uri 'https://auto.drom.ru'

    def get(url)
      url = self.class.get(url)
      Nokogiri::HTML(url)
    end
  end
end
