class AddPostRefToLikes < ActiveRecord::Migration[7.0]
  def change
    add_reference :likes, :post, null: false, foreign_key: true
    add_column :likes, :post, :string
    add_index :likes, :post
  end
end
