require 'rails_helper'

RSpec.describe 'Comment Form', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user) do
    User.create(
      name: 'John Doe',
      photo: 'https://example.com/john.jpg',
      bio: 'I am a test user',
      posts_counter: 0
    )
  end

  let(:post) do
    Post.create(
      author: user,
      title: 'My Test Post',
      text: 'This is a test post.',
      likes_counter: 0,
      comments_counter: 0
    )
  end

  it 'allows a user to like a post' do
    visit user_post_path(user_id: user.id, id: post.id)

    # Get the initial number of likes
    initial_likes = post.likes_counter

    # Click on the "Like" button to like the post
    click_button 'Like'

    # Check that the like count has increased by 1
    expect(page).to have_content("Likes: #{initial_likes + 1}")
  end
end
