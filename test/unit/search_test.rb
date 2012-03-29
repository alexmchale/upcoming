require 'test_helper'

class SearchTest < ActiveSupport::TestCase

  def test_firefly_search_generates_records
    assert_equal 14, firefly.records.count
    assert firefly.records.all? { |r| r.name =~ /Firefly, Season 1/ }
  end

  def test_firefly_search_generates_search_results
    assert_equal 14, firefly.search_results.count
  end

  protected

  def firefly
    if !@firefly
      VCR.use_cassette "search_for_firefly" do
        @firefly = create :search_for_firefly
      end
    end

    @firefly
  end

end
