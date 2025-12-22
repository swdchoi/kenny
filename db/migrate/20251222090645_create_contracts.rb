class CreateContracts < ActiveRecord::Migration[8.0]
  def change
    create_table :contracts do |t|
      t.references :client_id, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.date :start_date
      t.date :end_date
      t.float :total_amount
      t.integer :status

      t.timestamps
    end
  end
end
