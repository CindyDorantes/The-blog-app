require 'rails_helper'

RSpec.describe 'user#show', type: :feature do
  include RSpecHtmlMatchers

  before :each do
    @first_user = User.create(name: 'Tom',
                              photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
                              bio: 'Teacher from Mexico.')

    @first_post = Post.create(author: @first_user, title: 'Hello', text: 'This is my first post')
    @second_post = Post.create(author: @first_user, title: 'Hello again', text: 'This is my second post. Welcome')
    @third_post = Post.create(author: @first_user, title: 'Hi', text: 'Whats up folks?')

    @first_comment = Comment.create(post: @first_post, author: @first_user, text: 'Hi Tom!')
    @second_comment = Comment.create(post: @first_post, author: @first_user, text: 'Interesting')
  end

  describe 'user index page' do
    # I can see the user's profile picture, username and number of posts.
    it 'shows users profile picture' do
      visit "/users/#{@first_user.id}"
      expect(page).to have_tag('img', src: @first_user.photo)
      expect(page).to have_content(@first_user.name)
      expect(page).to have_content("Number of posts: #{@first_user.posts_counter}")
    end

    # I can see the user's bio.
    it 'shows users bio' do
      visit "/users/#{@first_user.id}"
      expect(page).to have_content(@first_user.bio)
    end

    # I can see the user's first 3 posts.
    it 'shows users first 3 posts' do
      visit "/users/#{@first_user.id}"
      expect(page).to have_tag('section') do
        with_tag 'div', with: { class: 'user-post-preview' }, count: 3
      end
    end

    # I can see a button that lets me view all of a user's posts.
    it 'shows a button to all posts' do
      visit "/users/#{@first_user.id}"
      expect(page).to have_tag('button', text: 'See all posts')
    end

    # When I click a user's post, it redirects me to that post's show page.
    it 'redirects to post show page when cliked' do
      visit "/users/#{@first_user.id}"
      click_on(@first_post.title)
      expect(page).to have_current_path(user_post_path(@first_user.id, @first_post.id))
    end

    # When I click to see all posts, it redirects me to the user's post's index page.
    it 'redirects to user posts index when cliked' do
      visit "/users/#{@first_user.id}"
      click_link('See all posts')
      expect(page).to have_current_path("/users/#{@first_user.id}/posts")
    end
  end
end
