# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item do
    name        { Forgery::Basic.text }
    price       { Random.rand(20000) }
    description { Forgery::Basic.text }
    kind        { Random.rand(3) + 1 }
    enabled     { [true, false].sample }
  end
end
