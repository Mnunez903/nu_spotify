module NuSpotify
  class Album
    attr_reader :id,
                :type,
                :available_markets,
                :copyrights,
                :external_ids,
                :external_urls,
                :genres,
                :href,
                :images,
                :name,
                :popularity,
                :release_date,
                :release_date_precision,
                :uri,
                :artists,
                :tracks

    RESOURCE_BASE_URL = "/v1/albums"

    def self.find(id, client:)
      result = client.get(endpoint(id))
      self.new(result, client)
    end

    def self.endpoint(*ids)
      raise ArgumentError.new("wrong number of arguments (provide at least 1)") if ids.empty?

      if ids.one?
        endpoint_for_one(ids.first)
      else
        endpoint_for_many(ids)
      end
    end

    def self.endpoint_for_one(id)
      "#{RESOURCE_BASE_URL}/#{id}"
    end

    def self.endpoint_for_many(ids)
      "#{RESOURCE_BASE_URL}?ids=#{ids.join(',')}"
    end

    def initialize(result, client=nil)
      @id = result['id']
      @type = result['type']
      @available_markets = result['available_markets']
      @copyrights = result['copyrights']
      @external_ids = result['external_ids']
      @external_urls = result['external_urls']
      @genres = result['genres']
      @href = result['href']
      @images = result['images']
      @name = result['name']
      @popularity = result['popularity']
      @release_date = result['release_date']
      @release_date_precision = result['release_date_precision']
      @uri = result['uri']
      @client = client

      @artists = result['artists'].map { |artist| NuSpotify::Artist.new(artist) }
      @paged_tracks = result['tracks']
    end

    def tracks
      @tracks ||= fetch_tracks
    end

    private
    def paged_tracks
      @page_tracks
    end

    def client
      @client
    end

    def fetch_tracks
      tracks = []
      has_next = @paged_tracks["next"]
      result = @paged_tracks

      loop do
        items = result['items']
        items.each { |track| tracks.push NuSpotify::Track.new(track) }
        break unless has_next
        result = client.get(result["next"])
        has_next = result['next']
      end

      tracks
    end
  end
end
