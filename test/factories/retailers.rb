# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :retailer do
    name "iTunes"
  end

  factory :itunes, parent: :retailer do
    name "iTunes"
  end
end
