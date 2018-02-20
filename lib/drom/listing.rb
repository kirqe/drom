module Drom
  class Listing
    attr_reader :parsed

    def initialize(page)
      @page = page
      @parsed = {}
      parse_sections
    end

    private
      def format_key(key)
        key.gsub("\u00A0", "").delete(":")
      end

      def format_value(value)
        value.strip.gsub("\u00A0", "")
      end

      def parse_sections
        begin
          @page.search("span[data-section = 'auto-description'] .b-text-gray").each do |e|
            @parsed[format_key(e.children.text)] = format_value(e.next_sibling.text)
          end

          @page.search("span[data-section = 'auto-description'] p").each do |e|
            k, v = e.text.split(":")
            @parsed[format_key(k)] = format_value(v)
          end

          @parsed["Мощность"] = format_value(/(\w+ л.с)/.match(@parsed["Мощность"])[0])
          @parsed["Фото"] = @page.search(".b-advItemGallery__thumbs .b-advItemGallery__photo").map { |e| e["href"] }
          @parsed["Цена"] = format_value(@page.search("div.b-media-cont.b-media-cont_theme_dot").text.strip.delete("руб."))
        rescue NoMethodError
          print "Some fields are missing\n"
        end
      end
  end
end
