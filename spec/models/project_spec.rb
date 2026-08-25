require 'rails_helper'

RSpec.describe Project, type: :model do
  describe "validations" do
    it "requires a unique name for the same owner" do
      owner = create(:user)

      create(:project, name: "Project A", owner: owner)

      duplicate_project = build(
        :project,
        name: "Project A",
        owner: owner
      )

      expect(duplicate_project).not_to be_valid
    end
  end
end