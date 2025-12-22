class RemoveContractFromInvoice < ActiveRecord::Migration[8.0]
  def change
    remove_foreign_key :invoices, :contracts
    remove_index :invoices, :contract_id
    remove_column :invoices, :contract_id
  end
end
