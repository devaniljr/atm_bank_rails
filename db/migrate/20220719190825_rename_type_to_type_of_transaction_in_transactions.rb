class RenameTypeToTypeOfTransactionInTransactions < ActiveRecord::Migration[7.0]
  def change
    rename_column :transactions, :type, :type_of_transaction
  end
end
