module NuSpotify
  class Track
    def initialize(track)

    end

    def self.find(id, client:)
      self.new(id)
    end
  end
end