class TvEpisode < Record

  def season
    $1.to_i if self.name =~ /Season (\d+)/
  end

  def track
    parsed_result["trackNumber"]
  end

  def track_count
    parsed_result["trackCount"]
  end

  def show_name
    parsed_result["artistName"]
  end

  def <=> obj
    return -1 unless obj.kind_of? TvEpisode

    return self.release_date <=> obj.release_date if self.show_name != obj.show_name

    if self.season && obj.season
      return self.season <=> obj.season if self.season != obj.season
    else
      return 1 if self.season
      return -1 if obj.season
    end

    if self.track && obj.track
      # Tracks with number greater than 100 are special features.
      return 1 if self.track < 100 && obj.track >= 100
      return -1 if self.track >= 100 && obj.track < 100
      return self.track <=> obj.track
    end

    return 1 if self.track
    return -1 if obj.track
    return self.name <=> obj.name
  end

  def self.find_or_create_by_result retailer, result
    record = retailer.records.where(type: "TvEpisode", code: result["trackId"].to_s).first
    record ||= TvEpisode.create! retailer: retailer, code: result["trackId"]

    name = result["trackName"]
    name = "#{result["collectionName"]}: #{name}" if result["collectionName"].present?

    record.update_attributes! \
      name:         name,
      artwork_url:  result["artworkUrl100"],
      genre:        result["primaryGenreName"],
      rating:       result["contentAdvisoryRating"],
      description:  result["longDescription"],
      release_date: Time.parse(result["releaseDate"]),
      url:          retailer.affiliate_link(result["trackViewUrl"]),
      result:       result.to_json

    record
  end

  def self.is_match? search, result
    search.terms.all? { |term| result["collectionName"] =~ /#{term}/i }
  end

=begin
{
  "wrapperType":"track",
  "kind":"tv-episode",
  "artistId":459153362,
  "collectionId":467196195,
  "trackId":477654318,
  "artistName":"Revenge",
  "collectionName":"Revenge, Season 1",
  "trackName":"Charade",
  "collectionCensoredName":"Revenge, Season 1",
  "trackCensoredName":"Charade",
  "artistViewUrl":"http://itunes.apple.com/us/tv-show/revenge/id459153362?uo=4",
  "collectionViewUrl":"http://itunes.apple.com/us/tv-season/charade/id467196195?i=477654318&uo=4",
  "trackViewUrl":"http://itunes.apple.com/us/tv-season/charade/id467196195?i=477654318&uo=4",
  "previewUrl":"http://a1940.v.phobos.apple.com/us/r1000/062/Video/19/8e/51/mzm.qogfkvzg..640x480.h264lc.d2.p.m4v",
  "artworkUrl30":"http://a3.mzstatic.com/us/r1000/079/Video/69/41/2b/mzl.fpbcxatc.40x30-75.jpg",
  "artworkUrl60":"http://a1.mzstatic.com/us/r1000/079/Video/69/41/2b/mzl.fpbcxatc.80x60-75.jpg",
  "artworkUrl100":"http://a4.mzstatic.com/us/r1000/079/Video/69/41/2b/mzl.fpbcxatc.100x100-75.jpg",
  "collectionPrice":31.84, "trackPrice":1.99, "releaseDate":"2011-11-02T07:00:00Z",
  "collectionExplicitness":"notExplicit",
  "trackExplicitness":"notExplicit",
  "discCount":1, "discNumber":1, "trackCount":16, "trackNumber":7, "trackTimeMillis":2590719.0, "country":"USA",
  "currency":"USD",
  "primaryGenreName":"Drama",
  "contentAdvisoryRating":"TV-PG",
  "shortDescription":"A high-profile newspaper story interrupts the Graysons' wishes to lay low on their 25th wedding", 
  "longDescription":"A high-profile newspaper story interrupts the Graysons' wishes to lay low on their 25th wedding anniversary; Frank digs into Emily's past in hope of proving his loyalty to Victoria."
}
=end

end
