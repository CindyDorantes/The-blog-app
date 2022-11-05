require 'rails_helper'

RSpec.describe Post, type: :model do
  user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
  subject { Post.new(author: user, title: 'Hello', text: 'This is my first post') }

  before { subject.save }

  context 'Test Post validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'title should be present' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'title should be no longer than 250 chars' do
      long_title = 'This is supposed to be a really really long title that will test the validation for the post model that titles do not have more than two hundred and fifty characters but I see that I keep writing and have not reached the number of characters I need for this test'
      subject.title = long_title
      expect(subject).to_not be_valid
    end

    it 'comments_counter should be an integer' do
      subject.comments_counter = 'foo'
      expect(subject).to_not be_valid
    end

    it 'comments_counter should be an greater or equal to 0' do
      subject.comments_counter = 0
      expect(subject).to be_valid
    end

    it 'likes_counter should be an integer' do
      subject.likes_counter = 'foo'
      expect(subject).to_not be_valid
    end

    it 'likes_counter should be an greater or equal to 0' do
      subject.likes_counter = 0
      expect(subject).to be_valid
    end
  end

  context 'Test user methods' do
    it 'returns last five comments' do
      Comment.create(post: subject, author: user, text: 'Hi Tom!')
      Comment.create(post: subject, author: user, text: 'Interesting')
      Comment.create(post: subject, author: user, text: 'I dont agree')
      Comment.create(post: subject, author: user, text: 'I would like to know more')
      Comment.create(post: subject, author: user, text: 'Thanks for sharing')
      Comment.create(post: subject, author: user, text: 'Is that all?')
      last_comments = subject.last_five_comments
      expect(last_comments.length).to eq 5
    end
  end
end
