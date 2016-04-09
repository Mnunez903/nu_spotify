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

  context "result" do
    it "returns all the fields" do
      track = NuSpotify::Track.new(track_data)

      expect(track.id).to eq("34KTEhpPjq6IAgQg2yzJAL")
      expect(track.available_markets).to eq(track_data["available_markets"])
      expect(track.disk_number).to eq(track_data["disk_number"])
      expect(track.duration_ms).to eq(track_data["duration_ms"])
      expect(track.explicit).to eq(track_data["explicit"])
      expect(track.external_ids).to eq(track_data["external_ids"])
      expect(track.external_urls).to eq(track_data["external_urls"])
      expect(track.href).to eq(track_data["href"])
      expect(track.name).to eq(track_data["name"])
      expect(track.popularity).to eq(track_data["popularity"])
      expect(track.preview_url).to eq(track_data["preview_url"])
      expect(track.track_number).to eq(track_data["track_number"])
      expect(track.type).to eq(track_data["type"])

      expect(track.uri).to eq(track_data["uri"])
      expect(track.artists.first).to be_a(NuSpotify::Artist)
    end
  end

  def track_data
    {
      "album" => {
        "album_type" => "album",
        "available_markets" => [ "US" ],
        "external_urls" => {
          "spotify" => "https=>//open.spotify.com/album/0fLhefnjlIV3pGNF9Wo8CD"
        },
        "href" => "https=>//api.spotify.com/v1/albums/0fLhefnjlIV3pGNF9Wo8CD",
        "id" => "0fLhefnjlIV3pGNF9Wo8CD",
        "images" => [ {
          "height" => 640,
          "url" => "https=>//i.scdn.co/image/260c7a6da14bb13a4cc9e75bf5b549fb87fa22a9",
          "width" => 640
        }, {
          "height" => 300,
          "url" => "https=>//i.scdn.co/image/6f98acc4da4eb86ca2f9ebae5f8f173e59c5abef",
          "width" => 300
        }, {
          "height" => 64,
          "url" => "https=>//i.scdn.co/image/2da4d0271d9e4b1f37fd6c195e671d77ed61ca8f",
          "width" => 64
        } ],
        "name" => "Californication",
        "type" => "album",
        "uri" => "spotify=>album=>0fLhefnjlIV3pGNF9Wo8CD"
      },
      "artists" => [ {
        "external_urls" => {
          "spotify" => "https=>//open.spotify.com/artist/0L8ExT028jH3ddEcZwqJJ5"
        },
        "href" => "https=>//api.spotify.com/v1/artists/0L8ExT028jH3ddEcZwqJJ5",
        "id" => "0L8ExT028jH3ddEcZwqJJ5",
        "name" => "Red Hot Chili Peppers",
        "type" => "artist",
        "uri" => "spotify=>artist=>0L8ExT028jH3ddEcZwqJJ5"
      } ],
      "available_markets" => [ "US" ],
      "disc_number" => 1,
      "duration_ms" => 329733,
      "explicit" => false,
      "external_ids" => {
        "isrc" => "USWB19900690"
      },
      "external_urls" => {
        "spotify" => "https=>//open.spotify.com/track/34KTEhpPjq6IAgQg2yzJAL"
      },
      "href" => "https=>//api.spotify.com/v1/tracks/34KTEhpPjq6IAgQg2yzJAL",
      "id" => "34KTEhpPjq6IAgQg2yzJAL",
      "name" => "Californication",
      "popularity" => 70,
      "preview_url" => "https=>//p.scdn.co/mp3-preview/175ce440229d2fb5361756f3e68c9647b86a8eee",
      "track_number" => 6,
      "type" => "track",
      "uri" => "spotify=>track=>34KTEhpPjq6IAgQg2yzJAL"
    }
  end
end