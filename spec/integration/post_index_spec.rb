require 'rails_helper'

RSpec.describe 'post#index', type: :feature do
  include RSpecHtmlMatchers

  before :each do
    @first_user = User.create(name: 'Tom',
                              photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
                              bio: 'Teacher from Mexico.')

    @first_post = Post.create(author: @first_user, title: 'My presentation', text: 'This is my first post')
    @second_post = Post.create(author: @first_user, title: 'Hello again', text: 'This is my second post. Welcome')

    @first_comment = Comment.create(post: @first_post, author: @first_user, text: 'Hi Tom!')
    @second_comment = Comment.create(post: @first_post, author: @first_user, text: 'Interesting')
  end

  describe 'post index page' do
    # I can see the user's profile picture.
    it 'shows users profile picture' do
      visit "/users/#{@first_user.id}/posts"
      expect(page).to have_tag('img', src: @first_user.photo)
    end
    # I can see the user's username.
    it 'shows users username' do
      visit "/users/#{@first_user.id}/posts"
      expect(page).to have_content(@first_user.name)
    end
    # I can see the number of posts the user has written.
    it 'shows the number of posts' do
      visit "/users/#{@first_user.id}/posts"
      expect(page).to have_content("Number of posts: #{@first_user.posts_counter}")
    end
    # I can see a post's title.
    it 'shows a post title' do
      visit "/users/#{@first_user.id}/posts"
      expect(page).to have_tag('h3', @first_post.title)
      expect(page).to have_tag('h3', @second_post.title)
    end
    # I can see some of the post's body.
    it 'shows some of the post body' do
      visit "/users/#{@first_user.id}/posts"
      expect(page).to have_tag('p', @first_post.text)
    end
    # I can see the first comments on a post.
    it 'shows the firsts comments on a post' do
      visit "/users/#{@first_user.id}/posts"
      expect(page).to have_tag('div', with: { class: 'post-comments-preview' }) do
        with_tag 'p', count: 2
      end
    end
    # I can see how many comments a post has.
    it 'shows the number of posts' do
      visit "/users/#{@first_user.id}/posts"
      expect(page).to have_content("Comments: #{@first_post.comments_counter}")
    end
    # I can see how many likes a post has.
    it 'shows the number of posts' do
      visit "/users/#{@first_user.id}/posts"
      expect(page).to have_content("Likes: #{@first_post.likes_counter}")
    end
    # I can see a section for pagination if there are more posts than fit on the view.
    it 'shows pagination' do
      visit "/users/#{@first_user.id}/posts"
      expect(page).to have_content('Pagination')
    end
    # When I click on a post, it redirects me to that post's show page.
    it 'redirects to post show page when cliked' do
      visit "/users/#{@first_user.id}/posts"
      click_on(@first_post.title)
      expect(page).to have_current_path(user_post_path(@first_user.id, @first_post.id))
    end
  end
end
