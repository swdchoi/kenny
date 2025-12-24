class AddCompletedDateToMilestones < ActiveRecord::Migration[8.0]
  def change
    # 1. Change status from boolean to string
    change_column :milestones, :status, :string, default: "pending"

    # 2. Add completed_date
    add_column :milestones, :completed_date, :datetime

    # 3. Add description
    add_column :milestones, :description, :text
  end
end
