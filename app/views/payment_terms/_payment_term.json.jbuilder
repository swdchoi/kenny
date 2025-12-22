json.extract! payment_term, :id, :contract_id_id, :description, :percentage, :amount, :target_date, :status, :completed_date, :created_at, :updated_at
json.url payment_term_url(payment_term, format: :json)
