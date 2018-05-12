require 'net/http'
# @abstract An api object for interacting with the rubygems public API.
class RubygemsApi
  OWNER_HANDLE = :john_hayes_reed

  def self.call(endpoint)
    url = "https://rubygems.org#{send(endpoint)}"
    uri = URI(url)
    response = Net::HTTP.get(uri)

    JSON.parse(response)
  end

  # Gets the general information of all gems from a particular owner.
  #
  # @return [JSON]
  def self.all
    "/api/v1/owners/#{OWNER_HANDLE}/gems.json"
  end

  def self.bottled_decorators
    '/api/v1/versions/bottled_decorators.json'
  end

  def self.bottled_observers
    '/api/v1/versions/bottled_decorators.json'
  end

  def self.bottled_services
    '/api/v1/versions/bottled_decorators.json'
  end
end
