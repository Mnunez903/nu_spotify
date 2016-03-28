require 'spec_helper'

describe NuSpotify::Client do
  it "knows the base url" do
    expect(NuSpotify::Client::BASE_URL).to eq("https://api.spotify.com")
  end
  it "returns an album by id" do
    album = nil
    client = NuSpotify::Client.new

    VCR.use_cassette('get_dookie_album') do
      album = client.find_album('4uG8q3GPuWHQlRbswMIRS6')
    end

    expect(album).to be_a(NuSpotify::Album)
  end
end