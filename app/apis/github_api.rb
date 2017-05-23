require 'net/http'
# @abstract An api object for interacting with the Github public API.
class GithubApi
  OWNER_HANDLE = :'John-Hayes-Reed'

  def self.call(endpoint)
    url = "https://api.github.com#{send(endpoint)}"
    uri = URI(url)
    response = Net::HTTP.get(uri)

    JSON.parse(response)
  end

  def self.profile
    "/users/#{OWNER_HANDLE}"
  end

  def self.repos
    "/users/#{OWNER_HANDLE}/repos"
  end
end