class TaskPolicy < ApplicationPolicy
  def show?
    user_is_owner_or_member?
  end

  def create?
    user_is_owner_or_member?
  end

  def update?
    user_is_owner_or_member?
  end

  def destroy?
    return true if record.project.owner == user
    
    membership = record.project.memberships.find_by(user: user)

    return true if membership&.admin?

    record.assignee == user
  end

  private

  def user_is_owner_or_member?
    record.project.owner == user ||
      record.project.members.include?(user)
  end
end