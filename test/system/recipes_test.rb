require 'rails_helper'

RSpec.describe 'Recipe index/show', type: :system do
  describe 'Recipe index page' do
    let(:user) do
      User.create!(
        name: 'Tom',
        email: 'test@mail.com',
        password: '123456'
      )
    end
    let(:recipe) do
      Recipe.create!(
        name: 'icecream',
        preparation_time: 3,
        cooking_time: 4,
        description: 'This is capybara2',
        public: true,
        user: user
      )
    end
    before(:each) do
      visit recipes_path(user_id: user.id)
      recipe.save
    end

    it 'visiting the index' do
      visit recipes_url
      assert_selector 'h1', text: 'Recipes'
    end
  
    it 'should create recipe' do
      visit recipes_url
      assign(:current_user, user)
      click_on 'New recipe'
  
      fill_in 'Cooking time', with: recipe.cooking_time
      fill_in 'Description', with: recipe.description
      fill_in 'Name', with: recipe.name
      fill_in 'Preparation time', with: recipe.preparation_time
      check 'Public' if recipe.public
      page.find('#recipe_user_id', visible: false).set(user.id)
      click_on 'Create Recipe'
  
      assert_text 'Recipe was successfully created'
      click_on 'Back to recipes'
    end
  
    it 'should destroy Recipe' do
      visit recipes_url
      click_on 'Remove', match: :first
  
      # assert_text 'Recipe was successfully destroyed'
    end
  end
end

