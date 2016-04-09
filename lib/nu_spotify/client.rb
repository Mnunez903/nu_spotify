module NuSpotify
  class Client
    BASE_URL = "https://api.spotify.com"

    def find_track(id)
      NuSpotify::Track.find(id, client: self)
    end

    def find_album(id)
      NuSpotify::Album.find(id, client: self)
    end

    def get(url)
      if url.include?(BASE_URL)
        JSON.parse RestClient.get(url)
      else
        JSON.parse RestClient.get("#{BASE_URL}#{url}")
      end
    end

  end
end