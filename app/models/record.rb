class Record < ActiveRecord::Base

  belongs_to :retailer

  def self.class_for wrapperType, kind, collectionType
    return TvSeason if [ wrapperType, collectionType ] == [ "collection", "TV Season" ]
    return TvEpisode if [ wrapperType, kind ] == [ "track", "tv-episode" ]
    return Movie if [ wrapperType, kind ] == [ "track", "feature-movie" ]
  end

end
