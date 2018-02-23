require 'httparty'
require 'nokogiri'

module Drom
  class Client
    include HTTParty
    base_uri 'https://auto.drom.ru'

    def get(url)
      begin
        page = self.class.get(url)
        Nokogiri::HTML(page)
      rescue SocketError => e
        print "SocketError"
      end
    end
  end
end
