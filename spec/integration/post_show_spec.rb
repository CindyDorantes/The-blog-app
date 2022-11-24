require 'rails_helper'

RSpec.describe 'post#show', type: :feature do
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

  describe 'post show page' do
    # I can see the post's title.
    it 'shows a post title' do
      visit "/users/#{@first_user.id}/posts/#{@first_post.id}"
      expect(page).to have_content(@first_post.title)
    end
    # I can see who wrote the post.
    it 'shows the author' do
      visit "/users/#{@first_user.id}/posts/#{@first_post.id}"
      expect(page).to have_content(@first_user.name)
    end
    # I can see how many comments it has.
    it 'shows the number of posts' do
      visit "/users/#{@first_user.id}/posts/#{@first_post.id}"
      expect(page).to have_content("Comments: #{@first_post.comments_counter}")
    end
    # I can see how many likes it has.
    it 'shows the number of likes' do
      visit "/users/#{@first_user.id}/posts/#{@first_post.id}"
      expect(page).to have_content("Likes: #{@first_post.likes_counter}")
    end
    # I can see the post body.
    it 'shows the post body' do
      visit "/users/#{@first_user.id}/posts/#{@first_post.id}"
      expect(page).to have_tag('p', @first_post.text)
    end
    # I can see the username of each commentor. // I can see the comment each commentor left.
    it 'shows the username of each commentor and the comment' do
      visit "/users/#{@first_user.id}/posts/#{@first_post.id}"
      expect(page).to have_tag('div', with: { class: 'post-comments-preview' }) do
        with_tag 'p', text: "#{@first_comment.author.name}: #{@first_comment.text}"
      end
    end
  end
end
