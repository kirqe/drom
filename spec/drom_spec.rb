require "spec_helper"

RSpec.describe Drom do
  before :all do
    @search = Drom.search(make: "mazda", model: "rx-8", maxprice: 100000)
    @get_single = Drom.get_single_listing("https://rostov-na-donu.drom.ru/mazda/rx-8/26689748.html")
  end

  it "tests #Drom.search()" do
    expect(@search).to be_an_instance_of(Drom::Search)
  end

  it "tests #Drom.get_single_listing()" do
    expect(@get_single).to be_an_instance_of(Hash)
  end
end
