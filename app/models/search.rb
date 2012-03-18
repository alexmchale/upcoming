require "open-uri"

class Search

  include Enumerable

  def initialize options = {}
    @options = options
  end

  def options options = {}
    @options.merge! options
    self
  end

  def term term
    options term: term
  end

  def tv_show
    options media: "tvShow"
  end

  def tv_season
    options media: "tvShow", entity: "tvSeason"
  end

  def each
    options = @options.merge limit: 200
    parameters = options.map { |k, v| [ URI.encode(k.to_s), URI.encode(v.to_s) ].join "=" }.join "&"
    url = "http://itunes.apple.com/search?#{parameters}"
    json_data = open(url).read
    response = JSON.load json_data
    
    response["results"].each { |result| yield result }
    self
  end

end
