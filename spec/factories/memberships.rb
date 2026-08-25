FactoryBot.define do
  factory :membership do
    association :project
    association :user
    role { :member }
  end
end