require 'rails_helper'

RSpec.describe Plant, type: :model do
  before do
    @user = create(:user)
    @plant = create(:plant, user: @user)
  end
  
  describe 'バリデーション' do
    it 'nameがあれば、OK' do
      expect(@plant.valid?).to eq(true)
    end
    
    it 'nameが空だと、NG' do
      @plant.name = ''
      expect(@plant.valid?).to eq(false)
    end
  end
end
