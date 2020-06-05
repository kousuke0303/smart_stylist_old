require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = create(:user)
  end
  
  describe 'バリデーション' do
    it 'name、email、question、answer、password、password_confirmationがあれば、OK' do
      expect(@user.valid?).to eq(true)
    end
    
    it 'nameが空だと、NG' do
      @user.name = ''
      expect(@user.valid?).to eq(false)
    end
    
    it 'emailが空だと、NG' do
      @user.email = ''
      expect(@user.valid?).to eq(false)
    end
    
    it 'emailが正規表現でないと、NG' do
      @user.email = 'testtesttest'
      expect(@user.valid?).to eq(false)
    end
    
    it '秘密の質問がないと、NG' do
      @user.question = ''
      expect(@user.valid?).to eq(false)
    end
    
    it '回答がないと、NG' do
      @user.answer = ''
      expect(@user.valid?).to eq(false)
    end
    
    it 'passwordが空だと、NG' do
      @user.password = ''
      @user.password_confirmation = ''
      expect(@user.valid?).to eq(false)
    end
    
    it 'passwordとpassword_confirmationが一致しないと、NG' do
      @user.password = 'password'
      @user.password_confirmation = 'password1'
      expect(@user.valid?).to eq(false)
    end
    
    it 'passwordが6文字未満だと、NG' do
      @user.password = 'passw'
      @user.password_confirmation = 'passw'
      expect(@user.valid?).to eq(false)
    end
  end
end
