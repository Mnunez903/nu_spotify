module NuSpotify
  class Track
    attr_reader :id,
                :name

    def initialize(result, client=nil)
      @id = result['id']
      @name = result['name']
    end

    RESOURCE_BASE_URL = '/v1/tracks'

    def self.endpoint(*ids)
      raise ArgumentError.new("wrong number of arguments (provide at least 1)") if ids.empty?
      if ids.one?
        "#{RESOURCE_BASE_URL}/#{ids.first}"
      else
        "#{RESOURCE_BASE_URL}?ids=#{ids.join(',')}"
      end
    end

    def self.find(id, client:)
      result = client.get(endpoint(id))
      self.new(result, client)
    end
  end
end