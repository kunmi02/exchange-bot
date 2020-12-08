# frozen_string_literal: true

# module to request make a HTTP call to the external API
module Requester
  def self.call_api(address)
    url = URI(address)
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end
end
