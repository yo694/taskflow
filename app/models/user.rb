class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :owned_projects,
           class_name: "Project",
           foreign_key: :owner_id

  has_many :memberships

  has_many :projects,
           through: :memberships

  has_many :assigned_tasks,
           class_name: "Task",
           foreign_key: :assignee_id

  before_destroy :cannot_delete_if_associated

  private

  def cannot_delete_if_associated
    if owned_projects.exists? || memberships.exists?
      errors.add(
        :base,
        "Cannot delete account while you are associated with projects."
      )
      throw(:abort)
    end
  end
end