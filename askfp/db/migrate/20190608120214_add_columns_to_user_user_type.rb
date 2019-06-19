class AddColumnsToUserUserType < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :user_type, :string, default: "guest", null: false
  end
end
