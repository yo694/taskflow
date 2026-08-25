FactoryBot.define do
  factory :task do
    association :project
    association :assignee, factory: :user
    title { "MyString" }
    status { :todo }
    due_on { Date.current }
    completed_at { nil }
  end
end