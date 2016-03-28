require 'spec_helper'
require 'vcr'

describe NuSpotify::Album do
  it "returns for one album" do
    endpoint = NuSpotify::Album.endpoint("beef")
    expect(endpoint).to eq("/v1/albums/beef")
  end

  it "returns for several albums" do
    endpoint = NuSpotify::Album.endpoint("beef", "ham")
    expect(endpoint).to eq("/v1/albums?ids=beef,ham")
  end

  it "raises error if no arguments given" do
    expect {
    NuSpotify::Album.endpoint
  }.to raise_error(ArgumentError)
  end

  xit "finds an album by id" do
    client = NuSpotify::Client.new
    album = NuSpotify::Album.find('4uG8q3GPuWHQlRbswMIRS6', client: client)
    expect(album.name).to eq("Dookie (U.S. Version)")
  end

  context "results" do
    it "returns all of the fields" do
      client = NuSpotify::Client.new

      album = nil

      VCR.use_cassette('get_dookie_album') do
        album = NuSpotify::Album.find('4uG8q3GPuWHQlRbswMIRS6', client: client)
      end

      expect(album.id).to eq("4uG8q3GPuWHQlRbswMIRS6")
      expect(album.type).to eq('album')
      expect(album.available_markets).to eq(["AD", "AR", "AT", "AU", "BE", "BG", "BO", "BR", "CA", "CH", "CL", "CO", "CR", "CY", "CZ", "DE", "DK", "DO", "EC", "EE", "ES", "FI", "FR", "GB", "GR", "GT", "HK", "HN", "HU", "IE", "IS", "IT", "LI", "LT", "LU", "LV", "MC", "MT", "MX", "MY", "NI", "NL", "NO", "NZ", "PA", "PE", "PH", "PL", "PT", "PY", "RO", "SE", "SG", "SI", "SK", "SV", "TR", "TW", "US", "UY"])
      expect(album.copyrights).to eq([{"text"=>"1994 Reprise Records for the U.S. and WEA International Inc. for the world outside of the U.S.", "type"=>"C"}, {"text"=>"1994 Reprise Records for the U.S. and WEA International Inc. for the world outside of the U.S.", "type"=>"P"}])
      expect(album.external_ids).to eq({"upc"=>"093624552963"})
      expect(album.external_urls).to eq({"spotify"=>"https://open.spotify.com/album/4uG8q3GPuWHQlRbswMIRS6"})
      expect(album.genres).to eq([])
      expect(album.href).to eq("https://api.spotify.com/v1/albums/4uG8q3GPuWHQlRbswMIRS6")
      expect(album.images).to eq([{"height"=>640, "url"=>"https://i.scdn.co/image/3a1ec3bdc44d89ed93bf99d12138139469731b14", "width"=>640},
                                  {"height"=>300, "url"=>"https://i.scdn.co/image/4bf06c01a3911f76a386524c1fd675249e342c2f", "width"=>300},
                                  {"height"=>64, "url"=>"https://i.scdn.co/image/eae6056da5ef1ff130aef71732388b1d51af5d30", "width"=>64}])
      expect(album.name).to eq("Dookie (U.S. Version)")
      expect(album.popularity).to eq(76)
      expect(album.release_date).to eq("1994-02-01")
      expect(album.release_date_precision).to eq("day")
      expect(album.uri).to eq("spotify:album:4uG8q3GPuWHQlRbswMIRS6")
      expect(album.artists.first).to be_a(NuSpotify::Artist)
      expect(album.tracks.first).to be_a(NuSpotify::Track)
      expect(album.tracks.count).to eq(15)
    end

    it "fetches all tracks" do
      client = NuSpotify::Client.new

      album = nil

      VCR.use_cassette('get_sweet_90s_album') do
        album = NuSpotify::Album.find('71WupOKqXgSrgg0CivZDHS', client: client)
        album.tracks
      end
      
      expect(album.tracks.count).to eq(90)
    end
  end
end