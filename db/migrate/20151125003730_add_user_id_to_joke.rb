class AddUserIdToJoke < ActiveRecord::Migration
  def change
    add_column :jokes, :user_id, :integer
  end
end
