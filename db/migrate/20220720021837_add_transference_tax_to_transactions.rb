class AddTransferenceTaxToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :transference_tax, :float, default: 0.0
  end
end
