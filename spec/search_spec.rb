require "spec_helper"

RSpec.describe Drom::Search do
  it "#start_url returns valid path" do
    s = Drom::Search.new
    res = s.send(:start_page, make: "mazda", model: "rx-8", maxprice: 300000)
    expect(res).to eq("/mazda/rx-8/page1/?maxprice=300000")
  end
end
