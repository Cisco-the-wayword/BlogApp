require 'rails_helper'

RSpec.describe User, type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:tom) do
    User.create(
      name: 'Tom Jenkins',
      photo: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqI5QUajL66Kkwz9efY-xCyC_Bq97XyTvgPmndMocETt62-ps3VjrzLtWNrDq_Y5qa5fQ',
      bio: 'I\'m Tom, and I thrive on the thrill of innovation and creativity!',
      posts_counter: 0
    )
  end

  let(:nancy) do
    User.create(
      name: 'Nancy Wheeler',
      photo: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5NAZBo2UrrQpRlk5paG6I23mWYsoSSXA-qw',
      bio: 'Hi there, I\'m Nancy! I\'m not just your typical actress;',
      posts_counter: 0
    )
  end

  let(:jane) do
    User.create(
      name: 'Jane Mute',
      photo: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQm48hud8Rmxfcr21GAjCeqJ2PfS-foEjPbcQ&usqp=CAU',
      bio: 'Hi there, I\'m Jane! I thrive on embracing life.',
      posts_counter: 0
    )
  end

  let(:brian) do
    User.create(
      name: 'Brian Tally',
      photo: 'https://static.wikia.nocookie.net/familyguy/images/c/c2/FamilyGuy_Single_BrianWriter_R7.jpg',
      bio: 'Hey there, I\'m Brian! I\'m a fun-loving individual with an infectious sense of humor.',
      posts_counter: 0
    )
  end

  let(:first_post) do
    Post.create(
      author: brian,
      title: 'Welcome to my blog',
      text: 'This is my first post',
      likes_counter: 0,
      comments_counter: 0
    )
  end

  let(:second_post) do
    Post.create(
      author: brian,
      title: 'Welcome to my second post',
      text: 'This is my second post',
      likes_counter: 0,
      comments_counter: 0
    )
  end

  let(:third_post) do
    Post.create(
      author: brian,
      title: 'Welcome to my third post',
      text: 'This is my third post',
      likes_counter: 0,
      comments_counter: 0
    )
  end

  before do
    tom
    nancy
    jane
    brian
  end

  context 'index page test group 1' do
    before { visit root_path }

    it 'shows the username of each user' do
      expect(page).to have_content(tom.name)
      expect(page).to have_content(nancy.name)
      expect(page).to have_content(jane.name)
      expect(page).to have_content(brian.name)
    end

    it 'shows the profile picture of each user' do
      profile_pictures = all('img.user-image')

      expect(profile_pictures[0]).to be_visible
      expect(profile_pictures[1]).to be_visible
      expect(profile_pictures[2]).to be_visible
      expect(profile_pictures[3]).to be_visible
      expect(profile_pictures[0]['src']).to eq tom.photo
      expect(profile_pictures[1]['src']).to eq nancy.photo
      expect(profile_pictures[2]['src']).to eq jane.photo
      expect(profile_pictures[3]['src']).to eq brian.photo
    end
  end

  context 'index page test group 2' do
    before { visit root_path }
    it 'shows the number of posts each user has written' do
      user_tiles = all('li.user-tile')

      user_tiles.each do |user_tile|
        expect(user_tile).to have_content(/\d+ Post/)
      end
    end

    it 'redirects to a user\'s show page on click' do
      toms_show_page_url = "#{Capybara.app_host}/users/#{tom.id}"

      click_link tom.name

      expect(page).to have_current_path(toms_show_page_url)
    end
  end
end
