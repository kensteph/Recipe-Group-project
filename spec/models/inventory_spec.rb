require 'rails_helper'

RSpec.describe Inventory, type: :model do
  let(:user) { User.new(name: 'Roody', email: 'roody@mail.com') }
  let(:inventory) do
    Inventory.create(
      name: 'My first inventory',
      description: 'This is my first inventory',
      user_id: user
    )
  end

  describe 'attributes' do
    it 'Should have a name' do
      expect(inventory.name).to eq('My first inventory')
    end

    it 'Should have a description' do
      expect(inventory.description).to eq('This is my first inventory')
    end
  end
end
