require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "status" do
    it "has the expected statuses" do
      expect(Task.statuses.keys).to contain_exactly(
        "todo",
        "in_progress",
        "done"
      )
    end
  end

  describe "completed_at callback" do
    it "sets completed_at when status changes to done" do
      task = create(:task, status: :todo)

      task.update!(status: :done)

      expect(task.completed_at).to be_present
    end

    it "clears completed_at when status changes away from done" do
      task = create(:task, status: :done)

      expect(task.completed_at).to be_present

      task.update!(status: :todo)

      expect(task.completed_at).to be_nil
    end
  end
end