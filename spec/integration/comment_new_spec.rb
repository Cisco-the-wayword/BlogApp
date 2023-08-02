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

  it 'allows a user to add a new comment' do
    visit user_post_path(user_id: user.id, id: post.id)

    # Click on the "Comments" link to make the new comment form appear
    click_link 'Comment'

    # Fill in the comment text in the form using the id attribute
    fill_in 'comment_text', with: 'This is a new comment.'

    # Click the Submit button
    click_button 'Submit'

    expect(page).to have_content('comment created succesfully')

    # Check that the comment form is hidden again after submitting the comment
    expect(page).not_to have_css('.new-comment-form')
  end
end
