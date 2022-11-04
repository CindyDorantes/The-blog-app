class AddPostRefToComment < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :post, null: false, foreign_key: true
    add_column :comments, :post, :string
    add_index :comments, :post
  end
end
