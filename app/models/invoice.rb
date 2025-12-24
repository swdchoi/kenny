class Invoice < ApplicationRecord
  belongs_to :payment_term

  validates :issue_date, presence: true
  validates :due_date, presence: true

  def derived_status
    return "paid" if paid_date.present?

    if issue_date.present?
      return "overdue" if due_date.present? && due_date < Date.current
      return "issued"
    end

    "draft"
  end


  scope :this_month, -> {
    where("issue_date >= ?", Date.current.beginning_of_month)
  }

  scope :overdue, -> {
    where(status: :issued).where("due_date < ?", Date.current)
  }
end
