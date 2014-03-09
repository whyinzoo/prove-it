require "rubygems"
require "oauth"

class Desk
  BASE_URL    = "https://desktester263.desk.com"
  CASES_URL   = "/api/v2/cases"
  FILTERS_URL = "/api/v2/filters"
  LABELS_URL  = "/api/v2/labels"

  @@consumer = OAuth::Consumer.new(
    "eNo6p8eIJI7UnZS4oilC",
    "TTlEMF5xI8J5VT3EweEXcOT4IIBJQqN4NkgnFXFM",
    :site => BASE_URL,
    :scheme => :header
  )  

  @@access_token = OAuth::AccessToken.from_hash(
    @@consumer,
    :oauth_token => "YJOGYUZvVYNC40jAennr",
    :oauth_token_secret => "JJIOuXBwULfSJYPX6dNrhy60MkXcrg5TZ643PzFx")
end


