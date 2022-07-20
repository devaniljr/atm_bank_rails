class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :type
      t.string :amount
      t.string :destination
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
