class CreateInvoices < ActiveRecord::Migration[8.0]
  def change
    create_table :invoices do |t|
      t.references :contract_id, null: false, foreign_key: true
      t.references :payment_term_id, null: false, foreign_key: true
      t.integer :status
      t.date :issue_date
      t.date :due_date
      t.date :paid_date

      t.timestamps
    end
  end
end
