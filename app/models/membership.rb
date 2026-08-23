class Membership < ApplicationRecord
  belongs_to :project
  belongs_to :user

  enum :role,
   { member: 0,
    admin: 1 },
     default: :member

  validates :user_id,
            uniqueness: { scope: :project_id }
end