module NuSpotify
  class Client
    BASE_URL = "https://api.spotify.com"
    def find_album(id)
      NuSpotify::Album.find(id, client: self)
    end

    def get(url)
      raw_get(BASE_URL + url)
    end
  end
end