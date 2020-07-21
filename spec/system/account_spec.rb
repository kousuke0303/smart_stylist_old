require 'rails_helper'

RSpec.describe 'アカウント機能', type: :system do
  before do
    @year = Time.now.year + 1
    visit login_path
  end
  
  describe 'アカウント作成・削除機能' do
    it 'アカウントが作成・削除される' do
      click_on '新規アカウント作成'
      check 'confirm-consent'
      click_on 'アカウント情報入力画面へ'
      fill_in 'user[name]', with: 'test'
      fill_in 'user[email]', with: 'test@email.com'
      fill_in 'user[answer]', with: 'answer'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      fill_in 'user[number]', with: '4242424242424242'
      fill_in 'user[cvc]', with: '111'
      fill_in 'user[exp_month]', with: '111'
      fill_in 'user[exp_year]', with: @year
      click_on '新規作成'
      click_on 'メニュー'
      click_on 'アカウント'
      page.accept_confirm do
        click_on 'アカウントを削除'
      end
      expect(page).to have_selector '.alert-success', text: 'testのデータを削除しました。'
    end
  end
end