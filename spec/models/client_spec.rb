require 'rails_helper'

RSpec.describe Client, type: :model do
  before do
    @user = create(:user)
    @client = create(:client, user: @user)
  end
  
  describe 'バリデーション' do
    it 'name、フリガナがあれば、OK' do
      expect(@client.valid?).to eq(true)
    end
    
    it 'nameが空だと、NG' do
      @client.name = ''
      expect(@client.valid?).to eq(false)
    end
    
    it 'フリガナが空だと、NG' do
      @client.name = ''
      expect(@client.valid?).to eq(false)
    end
    
    it 'フリガナが平仮名だと、NG' do
      @client.kana = 'やまだ　たろう'
      expect(@client.valid?).to eq(false)
    end
    
    it 'フリガナがアルファベットだと、NG' do
      @client.kana = 'yamada　tarou'
      expect(@client.valid?).to eq(false)
    end
    
    it 'フリガナが数字だと、NG' do
      @client.kana = '111　111'
      expect(@client.valid?).to eq(false)
    end
  end
end
