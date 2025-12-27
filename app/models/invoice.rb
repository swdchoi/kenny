class Invoice < ApplicationRecord
  belongs_to :payment_term
  has_many :notes, dependent: :destroy

  validates :issue_date, presence: true
  validates :due_date, presence: true

  after_update :updatepaymentterms, if: :saved_change_to_paid_date?

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

  scope :issued, -> { where.not(issue_date: nil) }
  scope :collected, -> { where.not(paid_date: nil) }
  scope :outstanding, -> { issued.where(paid_date: nil).where("due_date >= ?", Date.current) }
  scope :late, -> { where("due_date < ?", Date.today).where(paid_date: nil) }

  private

  def updatepaymentterms
    payment_term.update!(status: :completed)
  end
end
