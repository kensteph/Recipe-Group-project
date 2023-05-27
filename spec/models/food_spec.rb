require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { User.new(name: 'Roody', email: 'roody@mail.com') }
  let(:food) do
    Food.create(
      name: 'Apple',
      measurement_unit: 'grams',
      price: 4.0,
      user_id: user
    )
  end

  describe 'attributes' do
    it 'Should have a name' do
      expect(food.name).to eq('Apple')
    end

    it 'Should have "grams" as measurement unit' do
      expect(food.measurement_unit).to eq('grams')
    end

    it 'Should have a price of 4' do
      expect(food.price).to eq(4.0)
    end
  end
end
