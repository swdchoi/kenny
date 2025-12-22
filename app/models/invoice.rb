class Invoice < ApplicationRecord
  belongs_to :contract
  belongs_to :payment_term

  validates :invoice_number, presence: true, uniqueness: true
  validates :amount, presence: true
  validates :issue_date, presence: true
  validates :due_date, presence: true

  enum :status, {
    draft: 0,
    issued: 1,
    paid: 2,
    overdue: 3
  }

  scope :this_month, -> {
    where("issue_date >= ?", Date.current.beginning_of_month)
  }

  scope :overdue, -> {
    where(status: :issued).where("due_date < ?", Date.current)
  }
end
