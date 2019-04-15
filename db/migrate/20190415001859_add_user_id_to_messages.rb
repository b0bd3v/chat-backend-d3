class AddUserIdToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :user_id, :string, :null => true
  end
end
