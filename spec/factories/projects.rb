FactoryBot.define do
  factory :project do
    name { "MyString" }
    description { "MyText" }
    owner { nil }
    tasks_count { 1 }
  end
end
