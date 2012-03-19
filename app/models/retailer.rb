class Retailer < ActiveRecord::Base

  has_many :records

  def affiliate_link url
    # http://www.apple.com/itunes/affiliates/resources/documentation/linking-to-the-itunes-music-store.html#AffiliateEncodingLinkShare

    # Add LinkShare partner code.
    url +=
      if url =~ /\?/
        "&partnerId=30"
      else
        "?partnerId=30"
      end

    # Encode the url twice for iTunes.
    url = CGI.escape CGI.escape url

    # Prepend the LinkShare wrapper.
    wrapper = "http://click.linksynergy.com/fs-bin/click?id=pI1Hpk0GogU&subid=&offerid=146261.1&type=10&tmpid=3909&RD_PARM1="
    url = wrapper + url

    return url
  end

end
