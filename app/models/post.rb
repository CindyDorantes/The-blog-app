class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', counter_cache: :posts_counter
  has_many :comments
  has_many :likes

  validation :title, presence: true, length: { maximum: 250 }
  validation :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validation :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def last_five_comments
    comments.last(5)
  end
end

# Title must not be blank.
# Title must not exceed 250 characters.
# CommentsCounter must be an integer greater than or equal to zero.
# LikesCounter must be an integer greater than or equal to zero.
