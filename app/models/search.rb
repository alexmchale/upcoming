class Search < ActiveRecord::Base

  belongs_to :user
  belongs_to :retailer
  has_many :search_results, dependent: :delete_all
  has_many :records, through: :search_results

  before_create :execute_search
  after_create :initialize_records

  serialize :parameters

  scope :monitored, where(monitor_by_email: true)

  def term
    parameters[:term]
  end

  def terms
    term.to_s.split(/\s+/)
  end

  def style
    return "TV Episodes" if [ parameters[:media], parameters[:entity] ] == %w( tvShow tvEpisode )
    return "TV Seasons" if [ parameters[:media], parameters[:entity] ] == %w( tvShow tvSeason )
    return "Movies" if parameters[:media] == "movie"
  end

  def perform notify = nil
    self.execute_search
    self.initialize_records
  end

  def <=> obj
    return -1 unless obj.kind_of? Search

    term1 = self.term.downcase
    term2 = obj.term.downcase
    return term1 <=> term2 if term1 != term2

    self.created_at <=> obj.created_at
  end

  def execute_search
    options   = parameters.merge limit: 200
    encoded   = options.map { |k, v| [ URI.encode(k.to_s), URI.encode(v.to_s) ].join "=" }.join "&"
    url       = "http://itunes.apple.com/search?#{encoded}"
    json_data = open(url).read

    self.response = json_data
  end

  # Returns a list of new search results found.
  def initialize_records
    JSON.load(response)["results"].map do |result|
      klass = Record.class_for result["wrapperType"], result["kind"], result["collectionType"]
      next unless klass.is_match? self, result

      record = klass.find_or_create_by_result retailer, result
      unless search_result = search_results.where(record_id: record.id).first
        search_results.create!(record_id: record.id)
      end
    end.flatten.compact.uniq
  end

end
