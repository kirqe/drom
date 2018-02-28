module Drom
  class Search
    include Enumerable
    attr_reader :listings

    def initialize(options = {}, &block)
      @start_page = start_page(options)
      @listings = []
      @next_page = nil
      @progress_type = options[:status] || :none
      show_progress(@progress_type, &block) if valid_options?(options)
    end

    def <<(listing)
      @listings << listing
    end

    def each(&block)
      @listings.each(&block)
    end

    def to_csv
      csv = CSV.generate do |csv|
        self.listings.uniq.each do |l|
          csv << [l["Ссылка"], l.map {|k,v| "#{k}: #{v}"}.join("\r\n")]
        end
      end
      print "TOTAL #{@listings.size}\n"
      File.write("listings.csv", csv)
    end

    private
      def process_listings(&block)
        return if @start_page.nil?
        loop do
          page = Page.new(@start_page, &block)
          @listings += page.listings
          break unless page.next_page
          @start_page = page.next_page
        end
      end

      def start_page(options = {})
        default_options= { make: "", model: "", page: 1 }
        options = default_options.merge(options)
        "/%{make}/%{model}/page%{page}/?%{query}" % path_vals(options)
      end

      def path_vals(options)
        h = {}
        main_keys = [:make, :model, :page]

        main_keys.each { |key| h[key] = options[key] }
        h[:query] = options.reject! do |k, v|
          main_keys.include?(k)
        end.map { |k,v| "#{k}=#{v}" }.join("&")
        h
      end

      def valid_options?(options)
        [:make, :model].each do |k|
          return false if (options.has_key?(k) && options[k].empty?) || !options.has_key?(k)
        end
        true
      end

      def show_progress(progress_type, &block)
        case progress_type
        when :none then process_listings(&block)
        when :spinner then spinner { process_listings(&block) }
        end
      end

      def spinner(&block)
        Whirly.start spinner: "dots", status: "COLLECTING LISTINGS" do
          yield
        end
      end
  end
end
