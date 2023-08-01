require 'rails_helper'

RSpec.describe 'Post Show', type: :system do
  before do
    driven_by(:rack_test)
  end

context 'show page test group 1' do
  subject { brian }

  before do
    first_post
    second_post
    third_post
    visit user_path subject
  end

  it 'shows the user profile picture' do
    profile_picture = find('img')

    expect(profile_picture).to be_visible
    expect(profile_picture['src']).to eq subject.photo
  end

  it 'shows the user\'s name' do
    expect(page).to have_content(subject.name)
  end

  it 'shows the number of posts the user has written' do
    expect(page).to have_content("#{subject.posts_counter} Post#{subject.posts_counter == 1 ? '' : 's'}")
  end

  it 'shows the user bio' do
    expect(page).to have_content(subject.bio)
  end

  it 'shows the user\'s first three posts' do
    expect(page).to have_content(subject.posts[0].title)
    expect(page).to have_content(subject.posts[1].title)
    expect(page).to have_content(subject.posts[2].title)
  end

  it 'shows a button that shows all the user\'s posts when clicked' do
    expect(page).to have_link('See all posts')
  end
end

context 'show page test group 2' do
  subject { brian }

  before do
    first_post
    second_post
    third_post
    visit user_path subject
  end

  it 'redirects to the show page of a post when it is clicked' do
    first_post_url = "#{Capybara.app_host}/users/#{subject.id}/posts/#{subject.posts.first.id}"

    click_link subject.posts.first.title

    expect(page).to have_current_path(first_post_url)
    expect(page).to have_content(subject.posts.first.title)
    expect(page).to have_content(subject.posts.first.text)
  end

  it 'redirects to the post\'s index page when the \'See all posts\' link is clicked' do
    all_posts_url = "#{Capybara.app_host}/users/#{subject.id}/posts"

    click_link 'See all posts'
    expect(page).to have_current_path(all_posts_url)
  end
end
end
