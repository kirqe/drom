module Drom
  class Search
    attr_reader :initial_url, :listings

    def initialize(options = {}, &block)
      return [] if options.empty?
      @client = Client.new
      @start_url = start_url(options)
      @listings = []
      @next_page = ""
      Whirly.start spinner: "dots", status: "COLLECTING LISTINGS" do
        process_listings(&block)
      end
    end

    def to_csv
      s = CSV.generate do |csv|
        self.listings.uniq.each { |l| csv << [l["Ссылка"], l.map {|k,v| "#{k}: #{v}"}.join("\r\n")] }
      end
      print "TOTAL #{@listings.size}\n"
      File.write("listings.csv", s)
    end

    private
      def process_listings(&block)
        return if @start_url.nil?
        loop do
          page = Page.new(@start_url, &block)
          @listings += page.listings
          break unless page.next_page
          @start_url = page.next_page
        end
      end

      # fx this
      def start_url(options = {})
        default_options= { make: "", model: "", page: 1 }

        [:make, :model].each do |k|
          return if (options.has_key?(k) && options[k].empty?)
        end

        options = default_options.merge(options)
        make, model, page = [:make, :model, :page].map { |k| options[k] }

        options.reject! { |k, v| [:make, :model, :page].include?(k) }
        query = options.map { |k,v| "#{k}=#{v}" }.join("&")

        "/#{make}/#{model}/page#{page}/?#{query}"
      end
  end
end
