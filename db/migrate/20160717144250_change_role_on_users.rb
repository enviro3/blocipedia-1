class ChangeRoleOnUsers < ActiveRecord::Migration
  def change
    change_column_null :users, :role, false
    change_column_default :users, :role, 0
  end
end
