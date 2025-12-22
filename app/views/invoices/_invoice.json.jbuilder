json.extract! invoice, :id, :contract_id_id, :payment_term_id_id, :status, :issue_date, :due_date, :paid_date, :created_at, :updated_at
json.url invoice_url(invoice, format: :json)
