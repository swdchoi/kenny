class Invoice < ApplicationRecord
  belongs_to :contract_id
  belongs_to :payment_term_id
end
