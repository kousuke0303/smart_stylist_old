require 'rails_helper'

RSpec.describe 'アカウント作成機能', type: :system do
  before do
    visit login_path
    click_on '新規アカウント作成'
    check 'confirm-consent'
    click_on 'アカウント情報入力画面へ'
  end
  it 'アカウント作成機能' do
    expect(page).to have_content 'アカウント作成'
  end
end