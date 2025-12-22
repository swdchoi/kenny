class PaymentTerm < ApplicationRecord
  belongs_to :contract
  has_many :invoices

  validates :description, presence: true
  validates :percentage, presence: true
  validates :target_date, presence: true

  enum :status, { pending: 0, completed: 1 }

  scope :upcoming, -> {
    where(status: :pending)
      .where("target_date <= ?", 3.months.from_now)
      .order(:target_date)
  }
end
