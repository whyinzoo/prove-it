require "rubygems"
require "oauth"
require "json"

class Label < Desk
  COLORS = %w(default blue white yellow red orange green black purple brown grey pink)
  TYPES = %w(case macro article)

  def self.all
    JSON.parse @@access_token.get(LABELS_URL).body
  end

  def self.new_label(fields = {})
    body = JSON.generate(
      'name' => fields['name'],
      'description' => fields['description'],                                             
      'types' => fields['types'],                                                         
      'color' => fields['color']                                                          
    ) 
    
    response = @@access_token.post("#{LABELS_URL}",
      body,
      { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
    ) 
    
    JSON.parse response.body
  end

  def self.delete(label_id)
    @@access_token.delete("/api/v2/labels/#{label_id}")
  end
end
