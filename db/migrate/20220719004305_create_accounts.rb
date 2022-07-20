class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.decimal :balance

      t.timestamps
    end
  end
end
