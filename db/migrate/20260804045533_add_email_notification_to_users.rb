class AddEmailNotificationToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :email_notification, :boolean, default: true
  end
end
