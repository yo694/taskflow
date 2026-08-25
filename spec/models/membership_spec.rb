require 'rails_helper'

RSpec.describe Membership, type: :model do
  describe "validations" do
    it "does not allow the same user to join the same project twice" do
      user = create(:user)
      project = create(:project)

      create(:membership, user: user, project: project)

      duplicate_membership = build(
        :membership,
        user: user,
        project: project
      )

      expect(duplicate_membership).not_to be_valid
    end
  end
end