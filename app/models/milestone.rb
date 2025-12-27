class Milestone < ApplicationRecord
  belongs_to :contract
  has_one :payment_term

  after_update :unlock_payment_term, if: :saved_change_to_status?

  enum :status, {
  pending: "pending",
  completed: "completed",
  cancelled: "cancelled"
  }

  scope :pending, -> { where(completed_date: nil) }
  scope :upcoming, -> { pending.where("date >= ?", Date.today) }
  scope :overdue,  -> { pending.where("date < ?", Date.today) }

scope :finished, -> {
  where(status: [ :completed, :cancelled ])
}

  private

  def unlock_payment_term
    return unless status == "completed"
    return unless payment_term.present?

    payment_term.update!(
      status: :due,
      completed_date: completed_date || Time.current
    )
  end
end
