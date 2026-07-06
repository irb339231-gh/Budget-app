class CreateExpenditures < ActiveRecord::Migration[8.1]
  def change
    create_table :expenditures do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.integer :category, null: false
      t.integer :amount, null: false

      t.timestamps
    end
  end
end
