# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :search do
    parameters nil
    response nil
    monitor_by_email false
  end

  factory :search_for_firefly, parent: :search do
    parameters media: "tvShow", attribute: "showTerm", term: "firefly", entity: "tvEpisode"
  end

  factory :search_for_star_trek_movies, parent: :search do
    parameters media: "movie", attribute: "movieTerm", term: "star trek"
  end
end
