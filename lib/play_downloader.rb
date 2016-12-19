require 'net/http'

# Dowloads the play from http
class PlayDownloader
  def self.fetch(url)
    new(url).fetch
  end

  def initialize(url)
    @uri = URI.parse(url)
    @response = nil
  end

  def fetch
    # memoize the http calls to save requests
    @response ||= Net::HTTP.get_response(@uri).body
  rescue => e
    e.message
  end
end
