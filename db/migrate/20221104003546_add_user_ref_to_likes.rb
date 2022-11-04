class AddUserRefToLikes < ActiveRecord::Migration[7.0]
  def change
    add_reference :likes, :user, null: false, foreign_key: true
    add_column :likes, :user, :string
    add_index :likes, :user
  end
end
