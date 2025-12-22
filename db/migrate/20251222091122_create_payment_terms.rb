class CreatePaymentTerms < ActiveRecord::Migration[8.0]
  def change
    create_table :payment_terms do |t|
      t.references :contract_id, null: false, foreign_key: true
      t.string :description
      t.float :percentage
      t.float :amount
      t.date :target_date
      t.integer :status
      t.date :completed_date

      t.timestamps
    end
  end
end
