# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

first_user = User.create(email: 'tom@gmail.com', password: '123abc', name: 'Tom', photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
                         bio: 'Teacher from Mexico.')
second_user = User.create(email: 'lilly@gmail.com', password: '123abc', name: 'Lilly', photo: 'https://images.unsplash.com/photo-1665686310934-8fab52b3821b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8d29tYW58ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
                          bio: 'Teacher from Poland.')
User.create(name: 'Cindy', email: 'cindy@gmail.com', password: '123abc', role: 'admin', bio: 'The blog Creator',
            photo: 'https://picsum.photos/200')

first_post = Post.create(author: first_user, title: 'Hello', text: 'This is my first post')
second_post = Post.create(author: first_user, title: 'Hello again', text: 'This is my second post. Welcome')
third_post = Post.create(author: first_user, title: 'Hi', text: 'Whats up folks?')
fourth_post = Post.create(author: second_user, title: 'See you later', text: 'With this, I say goodbye')

Comment.create(post: first_post, author: second_user, text: 'Hi Tom!')
Comment.create(post: first_post, author: second_user, text: 'Interesting')
Comment.create(post: first_post, author: second_user, text: 'I dont agree')
Comment.create(post: first_post, author: second_user, text: 'I would like to know more')
Comment.create(post: first_post, author: second_user, text: 'Thanks for sharing')
Comment.create(post: first_post, author: second_user, text: 'Is that all?')

Like.create(post: first_post, author: second_user)
Like.create(post: second_post, author: second_user)
Like.create(post: third_post, author: second_user)
Like.create(post: fourth_post, author: second_user)
