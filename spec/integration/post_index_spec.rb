require 'rails_helper'

RSpec.describe 'Post Index', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user) do
    User.create(name: 'Adnan', photo: 'https://unsplash.com/photos/ABC123', posts_counter: 5)
  end

  # Assuming we have more than one post (greater than what fits on a single page)
  let!(:posts) do
    (1..10).map do |i|
      Post.create(title: "Post #{i}", text: "This is post #{i}", author: user, comments_counter: 0, likes_counter: 0)
    end
  end

  it "displays the user's profile picture on user posts page" do
    visit users_path(user_id: user.id)
    expect(page).to have_css("img[src='#{user.photo}']")
  end

  it "displays the user's name on user posts page" do
    visit users_path(user_id: user.id)
    expect(page).to have_content(user.name)
  end

  it "displays the user's post count on user posts page" do
    visit users_path(user_id: user.id)
    expect(page).to have_content(user.posts_counter)
  end

  it 'displays a post title on user posts page' do
    visit user_posts_path(user_id: user.id)
    expect(page).to have_content(posts.first.title)
  end

  it 'displays a post text on user posts page' do
    visit user_posts_path(user_id: user.id)
    expect(page).to have_content(posts.first.text)
  end

  it 'displays the first comments on a post' do
    visit user_posts_path(user_id: user.id)
    expect(page).to have_content(posts.first.comments.first.text)
  end

  it 'displays the number of comments on a post' do
    visit user_posts_path(user_id: user.id)
    expect(page).to have_content(posts.first.comments_counter)
  end

  it 'displays the number of likes on a post' do
    visit user_posts_path(user_id: user.id)
    expect(page).to have_content(posts.first.likes_counter)
  end

  it 'redirects to post show page when clicking on post title' do
    visit user_posts_path(user_id: user.id)
    click_link posts.first.title
    expect(page).to have_current_path(user_post_path(user_id: user.id, id: posts.first.id))
  end

  context 'pagination' do
    it 'displays pagination links' do
      visit user_posts_path(user_id: user.id)

      # Assuming we use some visual indicator for pagination links (e.g., the class "pagination")
      expect(page).to have_css('.pagination')
    end

    it 'navigates to the next page when clicking the "Next" link' do
      visit user_posts_path(user_id: user.id)

      # Assuming we use the text "Next" for the next page link
      click_link 'Next'

      expect(page).to have_current_path(user_posts_path(user_id: user.id, page: 2))
      expect(page).to have_content(posts[5].title) # Assuming the 6th post is displayed on the second page
    end

    # Similarly, you can add a test for the "Previous" link and other pagination behavior if applicable.
  end
end
