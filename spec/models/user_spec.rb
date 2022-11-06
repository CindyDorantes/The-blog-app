require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }

  before { subject.save }

  context 'Test user validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'name should be present' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'posts_counter should be an integer' do
      subject.posts_counter = 'foo'
      expect(subject).to_not be_valid
    end

    it 'posts_counter should be an greater or equal to 0' do
      subject.posts_counter = 0
      expect(subject).to be_valid
    end
  end

  context 'Test user methods' do
    it 'returns last three post by user' do
      Post.create(author: subject, title: 'Hello', text: 'This is my first post')
      Post.create(author: subject, title: 'Hello again', text: 'This is my second post. Welcome')
      Post.create(author: subject, title: 'Hi', text: 'Whats up folks?')
      Post.create(author: subject, title: 'See you later', text: 'With this, I say goodbye')
      last_posts = subject.last_three_post
      expect(last_posts.length).to eq 3
    end
  end
end
