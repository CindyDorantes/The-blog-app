class AddUserRefToComment < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :user, null: false, foreign_key: true
    add_column :comments, :user, :string
    add_index :comments, :user
  end
end
