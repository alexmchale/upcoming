class Record < ActiveRecord::Base

  belongs_to :retailer
  has_many :search_results, dependent: :delete_all
  has_many :searches, through: :search_results

  def parsed_result
    @parsed_result ||= JSON.load self.result
  end

  def self.class_for wrapperType, kind, collectionType
    return TvSeason if [ wrapperType, collectionType ] == [ "collection", "TV Season" ]
    return TvEpisode if [ wrapperType, kind ] == [ "track", "tv-episode" ]
    return Movie if [ wrapperType, kind ] == [ "track", "feature-movie" ]
  end

end
