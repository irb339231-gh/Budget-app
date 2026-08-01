class AddWizardCompletedToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :wizard_completed, :boolean, default: false, null: false
  end
end
