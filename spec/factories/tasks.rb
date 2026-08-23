FactoryBot.define do
  factory :task do
    project { nil }
    assignee { nil }
    title { "MyString" }
    status { 1 }
    due_on { "2026-08-21" }
    completed_at { "2026-08-21 07:02:58" }
  end
end
