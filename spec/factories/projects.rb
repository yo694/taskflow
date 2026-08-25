FactoryBot.define do
  factory :project do
    name { "MyString" }
    description { "MyText" }
    association :owner, factory: :user
  end
end