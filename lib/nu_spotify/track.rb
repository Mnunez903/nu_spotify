module NuSpotify
  class Track
    attr_reader :id,
                :name,
                :artists,
                :available_markets,
                :disk_number,
                :duration_ms,
                :explicit,
                :external_ids,
                :external_urls,
                :href,
                :popularity,
                :preview_url,
                :track_number,
                :type,
                :uri

    def initialize(result, client=nil)
      @id = result["id"]
      @name = result["name"]
      @available_markets = result["available_markets"]
      @disk_number = result["disk_number"]
      @duration_ms = result["duration_ms"]
      @explicit = result["explicit"]
      @external_ids = result["external_ids"]
      @external_urls = result["external_urls"]
      @href = result["href"]
      @popularity = result["popularity"]
      @preview_url = result["preview_url"]
      @track_number = result["track_number"]
      @type = result["type"]
      @uri = result["uri"]

      @artists = result['artists'].map { |artist| NuSpotify::Artist.new(artist) }
    end

    RESOURCE_BASE_URL = "/v1/tracks"

    def self.endpoint(*ids)
      raise ArgumentError.new("wrong number of arguments (provide at least 1)") if ids.empty?
      if ids.one?
        "#{RESOURCE_BASE_URL}/#{ids.first}"
      else
        "#{RESOURCE_BASE_URL}?ids=#{ids.join(",")}"
      end
    end

    def self.find(id, client:)
      result = client.get(endpoint(id))
      self.new(result, client)
    end
  end
end