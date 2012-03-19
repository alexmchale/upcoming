class Search < ActiveRecord::Base

  belongs_to :retailer
  has_many :search_results
  has_many :records, :through => :search_results

  before_create :execute_search
  after_create :initialize_records

  serialize :parameters

  def term
    parameters[:term]
  end

  def style
    return "TV Episodes" if [ parameters[:media], parameters[:entity] ] == %w( tvShow tvEpisode )
    return "TV Seasons" if [ parameters[:media], parameters[:entity] ] == %w( tvShow tvSeason )
    return "Movies" if parameters[:media] == "movie"
  end

  def perform
    self.execute_search
    self.initialize_records
  end

  protected

  def execute_search
    options   = parameters.merge limit: 50
    encoded   = options.map { |k, v| [ URI.encode(k.to_s), URI.encode(v.to_s) ].join "=" }.join "&"
    url       = "http://itunes.apple.com/search?#{encoded}"
    json_data = open(url).read

    self.response = json_data
  end

  def initialize_records
    JSON.load(response)["results"].each do |result|
      klass = Record.class_for result["wrapperType"], result["kind"], result["collectionType"]
      raise "cannot find class for #{result.inspect}" unless klass
      record = klass.find_or_create_by_result retailer, result
      search_result = search_results.where(record_id: record.id).first
      search_result ||= search_results.create!(record_id: record.id)
    end
  end

end
