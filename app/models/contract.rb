class Contract < ApplicationRecord
  belongs_to :client

  has_many :payment_terms, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :milestones, dependent: :destroy

  validates :title, presence: true
  validates :start_date, presence: true
  validates :total_amount, presence: true, numericality: { greater_than: 0 }

  enum :status, { active: 0, completed: 1, cancelled: 2 }
end
