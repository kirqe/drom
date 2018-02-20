module Drom
  class Search
    attr_reader :listings, :urls

    def initialize(options = {}, &block)
      @client = Client.new
      @initial_url = build_url(options)
      @urls = []
      @listings = []
      get_urls
      process_listings(&block)
    end

    private
      def process_listing(url)
        listing = Listing.new(@client.get(url)).parsed
        @listings << listing
        listing
      end

      def process_listings
        print "PROCESSING COLLECTED URLS\n"
        if @urls.any?
          @urls.each_slice(2) do |batch|
            batch.map do |url|
              Thread.new { yield process_listing(url) if block_given? }
            end.each(&:join)
          end
        else
          print "There are no search results to process\n"
        end
      end

      def get_urls
        print "COLLECTING URLS OF LISTINGS\n"
        page = @client.get(@initial_url)
        loop do
          page.search('.b-advItem').each do |a|
            @urls << a["href"]
            print "#{a["href"]}\n"
          end
          break if page.at_css(".b-pagination__item_next").nil?
          page = @client.get(page.at_css(".b-pagination__item_next")["href"])
        end
      end

      # fx this
      def build_url(options = {})
        default_options = {
          make: "",
          model: "",
          page: 1
        }
        options = default_options.merge(options)
        query = default_options.merge(options)

        reject_keys = [:make, :model, :page]
        query = query.reject! { |k, _| reject_keys.include?(k) }.map { |k,v| "&#{k}=#{v}" }.join("")


        if !options[:make].empty? && options[:model].empty?
          url = "https://auto.drom.ru/#{options[:make]}/all/page#{options[:page]}"
        elsif !options[:make].empty? && !options[:model].empty?
          url = "https://auto.drom.ru/#{options[:make]}/#{options[:model]}/page#{options[:page]}/?#{query}"
        end
        url
      end
  end
end
