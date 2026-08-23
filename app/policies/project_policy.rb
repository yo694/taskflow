class ProjectPolicy < ApplicationPolicy
  def show?
    user_is_owner_or_member?
  end

  def update?
    record.owner == user
  end

  def destroy?
    record.owner == user
  end

  def create?
    true
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope
      .left_joins(:memberships)
      .where(
        "projects.owner_id = :user_id OR memberships.user_id = :user_id",
        user_id: user.id
        )
        .distinct
      end
  end

  private

  def user_is_owner_or_member?
    record.owner == user || record.members.include?(user)
  end
end