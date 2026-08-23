class Project < ApplicationRecord
  belongs_to :owner, class_name: "User"

  has_many :memberships, dependent: :destroy

  has_many :members,
           through: :memberships,
           source: :user

  has_many :tasks, dependent: :destroy

  has_many :comments, as: :commentable

  validates :name,
            presence: true,
            uniqueness: { scope: :owner_id }
end