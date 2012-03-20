class Movie < Record

  def self.find_or_create_by_result retailer, result
    record = retailer.records.where(type: "Movie", code: result["trackId"].to_s).first
    record ||= Movie.create! retailer: retailer, code: result["trackId"]

    record.update_attributes! \
      name:         result["trackName"],
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
    terms = search.parameters[:term].to_s.split(/\s+/)
    terms.all? { |term| result["trackName"] =~ /#{term}/i }
  end

=begin
{
  "wrapperType":"track",
  "kind":"feature-movie",
  "artistId":81758682,
  "collectionId":429955014,
  "trackId":322447599,
  "artistName":"Pixar",
  "collectionName":"Finding Nemo / Up - Adventures with a Strange Pair to Faraway Lands",
  "trackName":"Up",
  "collectionCensoredName":"Finding Nemo / Up - Adventures with a Strange Pair to Faraway Lands",
  "trackCensoredName":"Up",
  "artistViewUrl":"http://itunes.apple.com/us/studio/pixar/id81758682?uo=4",
  "collectionViewUrl":"http://itunes.apple.com/us/movie/up/id322447599?uo=4",
  "trackViewUrl":"http://itunes.apple.com/us/movie/up/id322447599?uo=4",
  "previewUrl":"http://a246.v.phobos.apple.com/us/r1000/014/Video/94/4a/b9/mzm.avqhyvai..640x366.h264lc.d2.p.m4v",
  "artworkUrl30":"http://a5.mzstatic.com/us/r1000/059/Features/11/09/88/dj.vrglitja.30x30-50.jpg",
  "artworkUrl60":"http://a4.mzstatic.com/us/r1000/059/Features/11/09/88/dj.vrglitja.60x60-50.jpg",
  "artworkUrl100":"http://a1.mzstatic.com/us/r1000/059/Features/11/09/88/dj.vrglitja.100x100-75.jpg",
  "collectionPrice":14.99,
  "trackPrice":14.99,
  "releaseDate":"2009-05-29T07:00:00Z",
  "collectionExplicitness":"notExplicit",
  "trackExplicitness":"notExplicit",
  "discCount":1,
  "discNumber":1,
  "trackCount":2,
  "trackNumber":1,
  "trackTimeMillis":5768960.0,
  "country":"USA",
  "currency":"USD",
  "primaryGenreName":"Kids & Family",
  "contentAdvisoryRating":"PG", 
  "longDescription":"From the revolutionary minds of Pixar Animation Studios and the acclaimed director of Monsters, Inc. comes a hilariously uplifting adventure where the sky is no longer the limit. Carl Fredricksen, a retired balloon salesman is part rascal, part dreamer who is ready for his last chance at high-flying excitement. Tying thousands of balloons to his house, Carl sets off to the lost world of his childhood dreams. Unbeknownst to Carl, Russell, an overeager 8-year old Wilderness Explorer who has never ventured beyond his backyard, is in the wrong place at the wrong time \u2013 Carl's front porch! The world's most unlikely duo reaches new heights and meets fantastic friends like Dug, a dog with a special collar that allows him to speak, and Kevin, the rare 13-foot tall flightless bird. Stuck together in the wilds of the jungle, Carl realizes that sometimes life's biggest adventures aren't the ones you set out looking for. UP reaches new heights and it's an adventure that will send your spirits soaring!"
}
=end

end
