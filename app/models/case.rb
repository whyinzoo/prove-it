require "rubygems"
require "oauth"
require "json"

class Case < Desk
  def self.all
    JSON.parse @@access_token.get(CASES_URL).body
  end

  def self.first
    append_href = Filter.first['_links']['self']['href']
    JSON.parse @@access_token.get("#{append_href}/cases").body
  end

  def self.append(case_id, labels = [])
    body = JSON.generate(
      'labels' => labels,
      'label_action' => 'append'
    )

    response = @@access_token.put("#{CASES_URL}/#{case_id}",
      body,
      { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
    )

    JSON.parse response.body
  end
end
