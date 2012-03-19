# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :record do
    retailer nil
    code "MyString"
    name "MyString"
    artwork_url "MyText"
    genre "MyString"
    rating "MyString"
    description "MyText"
    release_date "2012-03-18"
    url "MyText"
    type ""
  end
end
