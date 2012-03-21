class TvSeason < Record

  def season
    $1.to_i if self.name =~ /, Season (\d+)$/
  end

  def show_name
    parsed_result["artistName"]
  end

  def <=> obj
    return -1 unless obj.kind_of? TvSeason

    return self.release_date <=> obj.release_date if self.show_name != obj.show_name
    return self.season.to_i <=> obj.season.to_i
  end

  def self.find_or_create_by_result retailer, result
    record = retailer.records.where(type: "TvSeason", code: result["collectionId"].to_s).first
    record ||= TvSeason.create! retailer: retailer, code: result["collectionId"]

    record.update_attributes! \
      name:         result["collectionName"].strip,
      artwork_url:  result["artworkUrl100"],
      genre:        result["primaryGenreName"],
      rating:       result["contentAdvisoryRating"],
      description:  result["longDescription"],
      release_date: Time.parse(result["releaseDate"]),
      url:          retailer.affiliate_link(result["collectionViewUrl"]),
      result:       result.to_json

    record
  end

  def self.is_match? search, result
    terms = search.parameters[:term].to_s.split(/\s+/)
    terms.all? { |term| result["collectionName"] =~ /#{term}/i }
  end

=begin
{
  "wrapperType":"collection",
  "collectionType":"TV Season",
  "artistId":459153362,
  "collectionId":467196195,
  "artistName":"Revenge",
  "collectionName":"Revenge, Season 1",
  "collectionCensoredName":"Revenge, Season 1",
  "artistViewUrl":"http://itunes.apple.com/us/tv-show/revenge/id459153362?uo=4",
  "collectionViewUrl":"http://itunes.apple.com/us/tv-season/revenge-season-1/id467196195?uo=4",
  "artworkUrl60":"http://a5.mzstatic.com/us/r1000/078/Video/47/62/62/mzl.bncqfqlg.60x60-50.jpg",
  "artworkUrl100":"http://a1.mzstatic.com/us/r1000/078/Video/47/62/62/mzl.bncqfqlg.100x100-75.jpg",
  "collectionPrice":31.84, "collectionExplicitness":"notExplicit",
  "contentAdvisoryRating":"TV-PG",
  "trackCount":16, "copyright":"ABC Studios INC, All Rights Reserved",
  "country":"USA",
  "currency":"USD",
  "releaseDate":"2011-09-21T07:00:00Z",
  "primaryGenreName":"Drama", 
  "longDescription":"Welcome to the Hamptons, a glittering world of wealth, opulence and power. But behind the glamour, lies a society full of dark secrets and betrayal. Meet Emily Thorne (Emily Van Camp), a sexy beauty driven by a desire to right some wrongs. When she moves into her beachfront mansion, everyone wonders about the new girl, but she knows everything about them, including who they are and what they did to her family. Years ago, they took everything from her. Now, one by one, she's going to make them pay. When it comes to revenge, money is no object, because only an eye for an eye will ever make things right. Get a glimpse into the lives of the filthy rich and the people who serve them in this scorching new thriller that asks: if someone stole everything from you, how far would you go to get revenge?"
}
=end

end
