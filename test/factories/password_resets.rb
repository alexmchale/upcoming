# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :password_reset do
    user nil
    uuid "MyString"
  end
end
