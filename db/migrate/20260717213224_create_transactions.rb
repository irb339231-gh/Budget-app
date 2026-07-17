class CreateTransactions < ActiveRecord::Migration[8.1]
  def change
    create_table :transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.integer :category, null: false
      t.integer :amount, null: false

      t.timestamps
    end
  end
end
