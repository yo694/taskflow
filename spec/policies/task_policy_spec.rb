require 'rails_helper'

RSpec.describe TaskPolicy, type: :policy do
  describe "#destroy?" do
    it "allows owner" do
      owner = create(:user)
      project = create(:project, owner: owner)
      task = create(:task, project: project)

      expect(described_class.new(owner, task).destroy?).to be true
    end

    it "allows admin member" do
      owner = create(:user)
      admin = create(:user)
      project = create(:project, owner: owner)
      create(:membership, project: project, user: admin, role: :admin)
      task = create(:task, project: project)

      expect(described_class.new(admin, task).destroy?).to be true
    end

    it "allows assignee" do
      owner = create(:user)
      assignee = create(:user)
      project = create(:project, owner: owner)
      task = create(:task, project: project, assignee: assignee)

      expect(described_class.new(assignee, task).destroy?).to be true
    end

    it "denies unrelated member" do
      owner = create(:user)
      member = create(:user)
      project = create(:project, owner: owner)
      create(:membership, project: project, user: member, role: :member)
      task = create(:task, project: project)

      expect(described_class.new(member, task).destroy?).to be false
    end
  end
end