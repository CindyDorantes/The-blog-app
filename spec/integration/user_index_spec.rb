require 'rails_helper'

RSpec.describe 'user#index', type: :feature do
  include RSpecHtmlMatchers

  before :each do
    @first_user = User.create(name: 'Tom',
                              photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
                              bio: 'Teacher from Mexico.')

    @first_post = Post.create(author: @first_user, title: 'Hello', text: 'This is my first post')
    @second_post = Post.create(author: @first_user, title: 'Hello again', text: 'This is my second post. Welcome')

    @first_comment = Comment.create(post: @first_post, author: @first_user, text: 'Hi Tom!')
    @second_comment = Comment.create(post: @first_post, author: @first_user, text: 'Interesting')
  end

  describe 'user index page' do
    # I can see the username of all other users.
    it 'shows the user name of all users' do
      visit '/'
      expect(page).to have_content(@first_user.name)
    end

    # I can see the profile picture for each user.
    it 'shows profile picture for each user' do
      visit '/'
      expect(page).to have_tag('img', src: @first_user.photo)
    end

    # I can see the number of posts each user has written.
    it 'shows the number of post for each user' do
      visit '/'
      expect(page).to have_content(@first_user.posts_counter)
    end

    # When I click on a user, I am redirected to that user's show page.
    it 'redirects to user show page when cliked' do
      visit '/'
      click_on(@first_user.name)
      expect(page).to have_current_path(user_path(@first_user.id))
    end
  end
end
