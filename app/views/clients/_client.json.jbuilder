json.extract! client, :id, :email, :company_name, :phone, :created_at, :updated_at
json.url client_url(client, format: :json)
