require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'Test Comment comments_counter method' do
    user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    post = Post.create(author: user, title: 'Hello', text: 'This is my first post')

    Like.create(post: post, author: user)
    Like.create(post: post, author: user)
    Like.create(post: post, author: user)
    Like.create(post: post, author: user)

    it 'post.likes_counter should equal 4' do
      expect(post.likes_counter).to eq(4)
    end
  end
end
