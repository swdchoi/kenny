class PaymentTerm < ApplicationRecord
  belongs_to :contract
  belongs_to :milestone, optional: true
  has_one :invoice, dependent: :destroy

  validates :description, presence: true
  validates :percentage, presence: true
  validates :target_date, presence: true

  enum :status, {
  pending: 0,        # milestone not completed yet
  due: 1,            # milestone completed → payment unlocked
  invoiced: 2,       # invoice created/sent
  completed: 3       # invoice paid
}

  scope :upcoming, -> {
    where(status: :pending)
      .where("target_date <= ?", 3.months.from_now)
      .order(:target_date)
  }
end
