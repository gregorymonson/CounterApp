class FixCounter < ActiveRecord::Migration
  def change
  	change_column :users, :login_counter, :integer, default: 1
  end
end
