require 'test_helper'

class SearchesControllerTest < ActionController::TestCase

  def test_new_search
    get :new

    assert_response :success
  end

  def test_searching_for_firefly
    VCR.use_cassette "search_for_firefly" do
      post :create, search: attributes_for(:search_for_firefly)
    end

    search = Search.last

    assert_not_nil search
    assert_equal 1, Search.count
    assert_redirected_to search_path(search)
    assert_equal 14, search.records.count
    assert search.records.all? { |r| r.name =~ /Firefly, Season 1:/ }
  end

  def test_searching_for_star_trek_movies
    VCR.use_cassette "search_for_star_trek_movies" do
      post :create, search: attributes_for(:search_for_star_trek_movies)
    end

    search = Search.last

    assert_not_nil search
    assert_equal 1, Search.count
    assert_redirected_to search_path(search)
    assert_equal 14, search.records.count
    assert search.records.all? { |r| r.name =~ /Star Trek/ }
  end

end
