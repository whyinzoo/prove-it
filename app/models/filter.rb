require "rubygems"
require "oauth"
require "json"

class Filter < Desk
  def self.all
    JSON.parse @@access_token.get(FILTERS_URL).body
  end 
      
  #assuming that the first position in the array is the first filter
  def self.first
    self.all['_embedded']['entries'][0]
  end
end
