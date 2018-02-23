require "spec_helper"

RSpec.describe Drom do
  it "has a version number" do
    expect(Drom::VERSION).not_to be nil
  end

  it "tests #Drom.search() return type" do
    res = Drom.search(make: "mazda", model: "rx-8", maxprice: 100000)
    expect(res).to be_an_instance_of(Drom::Search)
  end

  it "tests #Drom.search() return type" do
    res = Drom.get_single_listing("https://rostov-na-donu.drom.ru/mazda/rx-8/26689748.html")
    expect(res).to be_an_instance_of(Hash)
  end
end
