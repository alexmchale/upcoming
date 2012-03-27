# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :search do
    parameters nil
    response nil
    monitor_by_email false
  end

  factory :search_for_firefly, parent: :search do
    parameters({ attribute: "showTerm", term: "firefly", entity: "tvEpisode" })
  end
end
