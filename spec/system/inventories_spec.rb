require 'rails_helper'

RSpec.describe Inventory, type: :system do
  subject { Inventory.create(name: 'My Inventory', user_id: 1) }
  before { subject.save }

  describe 'index page' do
    it 'Should have content "Inventories"' do
      visit '/'
      expect(page).to have_content('Inventories')
    end
    # it 'shows the rendering of user Nelson name' do
    #   visit '/'
    #   expect(page).to have_content('Nelson')
    # end
    # it 'show the images from user Kender' do
    #   visit '/'
    #   expect(page.find("#user-#{kender.id}")['src']).to have_content 'https://picsum.photos/300/300'
    # end
    # it 'show the images from user Nelson' do
    #   visit '/'
    #   expect(page.find("#user-#{subject.id}")['src']).to have_content 'https://picsum.photos/300/300'
    # end
    # it 'show the posts_counter from user Kender' do
    #   visit '/'
    #   expect(page.find("#counter-#{kender.id}")).to have_content kender.posts_counter.to_s
    # end
    # it 'show the posts_counter from user Nelson' do
    #   visit '/'
    #   expect(page.find("#counter-#{subject.id}")).to have_content subject.posts_counter.to_s
    # end
    # it 'redirects from user index to user show Nelson' do
    #   visit '/' # Visit the user index page
    #   find('span', text: subject.name).click
    #   expect(page).to have_current_path("/users/#{subject.id}", ignore_query: true)
    # end
    # it 'redirects from user index to user show Kender' do
    #   visit '/' # Visit the user index page
    #   find('span', text: kender.name).click
    #   expect(page).to have_current_path("/users/#{kender.id}", ignore_query: true)
    # end
  end

  # Inventory SHOW PAGE
  describe 'User show page' do
    it "should display the inventory 's name at the top" do
      visit "/inventories/#{subject.id}"
      expect(page).to have_content(subject.name)
    end
    # it 'should render the username of the user' do
    #   visit "/users/#{subject.id}"
    #   expect(page).to have_content(subject.name)
    # end

    # it 'should render the  number of posts the user has written.' do
    #   visit "/users/#{subject.id}"
    #   expect(page.find('.custom-card-t')).to have_content subject.posts_counter.to_s
    # end

    # it 'should render the  bio of the user' do
    #   visit "/users/#{subject.id}"
    #   expect(page.find('.bio')).to have_content subject.bio.to_s
    # end

    # it 'should render the  3 first posts of the user' do
    #   visit "/users/#{subject.id}"
    #   expect(page).to have_selector('.post-item', count: 3)
    # end

    # it 'should render a button that lets me view all the posts of the user' do
    #   visit "/users/#{subject.id}"
    #   expect(page).to have_content 'See all posts'
    # end

    # it 'should redirect me to the show page of that post when the user clicks on the post' do
    #   visit "/users/#{subject.id}"
    #   find("#show-post-#{first_post.id}").click
    #   expect(page).to have_current_path("/users/#{subject.id}/posts/#{first_post.id}", ignore_query: true)
    # end

    # it 'should redirect me to the post index page when the user clicks on see all posts' do
    #   visit "/users/#{subject.id}"
    #   find('#all-posts').click
    #   expect(page).to have_current_path("/users/#{subject.id}/posts", ignore_query: true)
    # end
  end
end
