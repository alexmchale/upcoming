# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :search do
    retailer nil
    parameters "MyText"
    response "MyText"
  end
end
