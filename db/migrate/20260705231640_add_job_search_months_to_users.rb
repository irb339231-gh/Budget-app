class AddJobSearchMonthsToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :job_search_start_month, :date
    add_column :users, :job_search_end_month, :date
  end
end
