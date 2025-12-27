class PaymentTerm < ApplicationRecord
  belongs_to :contract
  belongs_to :milestone, optional: true
  has_one :invoice, dependent: :destroy

  validates :description, presence: true
  validates :percentage, presence: true
  validates :target_date, presence: true


  scope :upcoming, -> {
  where(status: :pending)
    .where("target_date >= ?", Date.today)
    }

  scope :overdue, -> {
    where(status: :pending)
      .where("target_date < ?", Date.today)
  }

  scope :done, -> {
      where(status: :completed)
    }


  scope :invoiced, -> {
    where(status: :invoiced)
  }

  enum :status, {
  pending: 0,        # milestone not completed yet
  due: 1,            # milestone completed → payment unlocked
  invoiced: 2,       # invoice created/sent
  completed: 3       # invoice paid
}

  scope :need_issue, -> {
  left_joins(:invoice)
    .where(status: :due)
    .where(invoices: { id: nil })
}
end
