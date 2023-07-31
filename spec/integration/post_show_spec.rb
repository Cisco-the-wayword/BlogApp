require 'rails_helper'

RSpec.describe 'Post Show', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user) do
    User.create(name: 'Adnan', photo: 'https://unsplash.com/photos/ABC123', posts_counter: 5)
  end

  let(:post) do
    Post.create(title: 'My First Post', text: 'This is my first post', author: user, comments_counter: 0,
                likes_counter: 0)
  end

  let!(:comment) do
    Comment.create(text: 'This is my first comment', author: user, post:)
  end

  it 'displays posts title' do
    visit user_post_path(user_id: user.id, id: post.id)
    expect(page).to have_content(post.title)
  end

  it 'displays who wrote the post' do
    visit user_post_path(user_id: user.id, id: post.id)
    expect(page).to have_content(user.name)
  end

  it 'displays how many comments the post has' do
    visit user_post_path(user_id: user.id, id: post.id)
    expect(page).to have_content(post.comments_counter)
  end

  it 'displays how many likes the post has' do
    visit user_post_path(user_id: user.id, id: post.id)
    expect(page).to have_content(post.likes_counter)
  end

  it 'displays the post text' do
    visit user_post_path(user_id: user.id, id: post.id)
    expect(page).to have_content(post.text)
  end

  it 'displays the user name commentor' do
    visit user_post_path(user_id: user.id, id: post.id)
    expect(page).to have_content(comment.author.name)
  end

  it 'displays the comment text' do
    visit user_post_path(user_id: user.id, id: post.id)
    expect(page).to have_content(comment.text)
  end
end
