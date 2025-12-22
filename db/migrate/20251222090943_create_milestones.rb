class CreateMilestones < ActiveRecord::Migration[8.0]
  def change
    create_table :milestones do |t|
      t.string :name
      t.date :date
      t.boolean :status
      t.references :contract, null: false, foreign_key: true

      t.timestamps
    end
  end
end
