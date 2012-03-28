class Record < ActiveRecord::Base

  belongs_to :retailer
  has_many :search_results, dependent: :delete_all
  has_many :searches, through: :search_results

  def parsed_result
    @parsed_result ||= JSON.load self.result
  end

  def preview_url
    @preview_url ||= parsed_result["previewUrl"]
  end

  def self.class_for wrapperType, kind, collectionType
    return TvSeason if [ wrapperType, collectionType ] == [ "collection", "TV Season" ]
    return TvEpisode if [ wrapperType, kind ] == [ "track", "tv-episode" ]
    return Movie if [ wrapperType, kind ] == [ "track", "feature-movie" ]

    fields = [ wrapperType, kind, collectionType ]
    raise RecordTypeNotFound.new "record type not found for #{fields.inspect}"
  end

  class RecordTypeNotFound < Exception; end

end
