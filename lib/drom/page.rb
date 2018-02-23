module Drom
  class Page
    attr_reader :urls, :listings, :next_page

    def initialize(url, &block)
      @client = Client.new
      @page_url = url
      @urls = []
      @listings = []
      @next_page = nil
      page_listings(&block)
    end

    private
    def process_listing(url)
      page = @client.get(url)
      listing = Listing.new(url, page).parsed
      @listings << listing
      listing
    end

    def page_listings(&block)
      page = @client.get(@page_url)
      @urls = page.search('.b-advItem').map { |a| a["href"] }
      @next_page = page.at_css(".b-pagination__item_next")["href"] if page.at_css(".b-pagination__item_next")

      if @urls.any?
        @urls.each_slice(2) do |batch|
          batch.map do |url|
            Thread.new do
              listing = process_listing(url)
              yield listing if block_given?
            end
          end.each(&:join)
        end
      end
    end
  end
end
