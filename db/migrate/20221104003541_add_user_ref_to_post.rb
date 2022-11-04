class AddUserRefToPost < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :user, null: false, foreign_key: true
    add_column :posts, :user, :string
    add_index :posts, :user
  end
end
