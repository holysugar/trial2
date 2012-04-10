# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item do
    name "MyString"
    price 1
    description "MyText"
    kind 1
    enabled false
  end
end
