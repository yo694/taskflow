class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
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

end
