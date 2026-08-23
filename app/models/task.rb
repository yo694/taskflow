class Task < ApplicationRecord
  belongs_to :project,
                     counter_cache: true

  belongs_to :assignee,
             class_name: "User",
             optional: true

  has_many :comments, as: :commentable

  enum :status, {
    todo: 0,
    in_progress: 1,
    done: 2
  }, default: :todo

  validates :title,
            presence: true,
            length: { in: 3..120 }

  validate :due_on_cannot_be_in_the_past, on: :create

  scope :overdue, -> {
    where.not(status: :done)
         .where("due_on < ?", Date.current)
  }

  before_save :set_completed_at

  private

  def due_on_cannot_be_in_the_past
    return if due_on.blank?
    return unless due_on < Date.current

    errors.add(:due_on, "cannot be in the past")
  end

  def set_completed_at
    if status_changed? && status == "done"
      self.completed_at = Time.current
    elsif status_changed? && status_was == "done"
      self.completed_at = nil
    end
  end
end