require "spec_helper"

describe NuSpotify::Track do
  it "returns with one track" do
    endpoint = NuSpotify::Track.endpoint("books")
    expect(endpoint).to eq("/v1/tracks/books")
  end

  it "returns for several tracks" do
    endpoint = NuSpotify::Track.endpoint("read", "book")
    expect(endpoint).to eq("/v1/tracks?ids=read,book")
  end

  it "raises error if no arguments are given" do
    expect {
      NuSpotify::Track.endpoint
    }.to raise_error(ArgumentError)
  end

  it "finds a track by id" do
    client = NuSpotify::Client.new
    track = nil
    VCR.use_cassette("californication_by_red_hot_chili_peppers") do
      track = NuSpotify::Track.find("34KTEhpPjq6IAgQg2yzJAL", client: client)
    end

    expect(track.name).to eq("Californication")
  end
end