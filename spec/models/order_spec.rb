require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    @user = create(:user)
    @client = create(:client, user: @user)
    @plant = create(:plant, user: @user)
    @order = create(:order, user: @user, client: @client, plant_id: @plant.id)
  end
  
  describe 'バリデーション' do
    it 'kind、ordered_on、plant_id、retail、kindがあれば、OK' do
      expect(@order.valid?).to eq(true)
    end
    
    it 'plant_idが空だと、NG' do
      @order.plant_id = ''
      expect(@order.valid?).to eq(false)
    end
    
    it 'retailが空だと、NG' do
      @order.retail = ''
      expect(@order.valid?).to eq(false)
    end
    
    it 'ordered_onが空だと、NG' do
      @order.ordered_on = ''
      expect(@order.valid?).to eq(false)
    end
    
    it 'kindが空だと、NG' do
      @order.kind = ''
      expect(@order.valid?).to eq(false)
    end
    
    it 'delivered_onが、ordered_onより早いと、NG' do
      @order.delivered_on = '2020-05-09'
      expect(@order.valid?).to eq(false)
    end
    
    it 'sold_onが、ordered_onより早いと、NG' do
      @order.sold_on = '2020-05-09'
      expect(@order.valid?).to eq(false)
    end
    
    it 'depositが、retailより多いと、NG' do
      @order.deposit = 100001
      expect(@order.valid?).to eq(false)
    end
    
    it 'wageが、retailより多いと、NG' do
      @order.wage = 100001
      expect(@order.valid?).to eq(false)
    end
    
    it 'clothが、retailより多いと、NG' do
      @order.cloth = 100001
      expect(@order.valid?).to eq(false)
    end
    
    it 'liningが、retailより多いと、NG' do
      @order.lining = 100001
      expect(@order.valid?).to eq(false)
    end
    
    it 'buttonが、retailより多いと、NG' do
      @order.button = 100001
      expect(@order.valid?).to eq(false)
    end
    
    it 'postageが、retailより多いと、NG' do
      @order.postage = 100001
      expect(@order.valid?).to eq(false)
    end
    
    it 'otherが、retailより多いと、NG' do
      @order.other = 100001
      expect(@order.valid?).to eq(false)
    end
    
    it 'wageが空で、wage_payがtrueだと、NG' do
      @order.wage = ''
      @order.wage_pay = true
      expect(@order.valid?).to eq(false)
    end
    
    it 'clothが空で、cloth_payがtrueだと、NG' do
      @order.cloth = ''
      @order.cloth_pay = true
      expect(@order.valid?).to eq(false)
    end
    
    it 'liningが空で、lining_payがtrueだと、NG' do
      @order.lining = ''
      @order.lining_pay = true
      expect(@order.valid?).to eq(false)
    end
    
    it 'buttonが空で、button_payがtrueだと、NG' do
      @order.button = ''
      @order.button_pay = true
      expect(@order.valid?).to eq(false)
    end
    
    it 'postageが空で、postage_payがtrueだと、NG' do
      @order.postage = ''
      @order.postage_pay = true
      expect(@order.valid?).to eq(false)
    end
    
    it 'otherが空で、other_payがtrueだと、NG' do
      @order.other = ''
      @order.other_pay = true
      expect(@order.valid?).to eq(false)
    end
    
    it 'noteが、151字以上だと、NG' do
      @order.note = 'a' * 151
      expect(@order.valid?).to eq(false)
    end
    
    it '費用合計が、retail以上だと、NG' do
      @order.wage = 20000
      @order.cloth = 20000
      @order.lining = 20000
      @order.button = 20000
      @order.postage = 20000
      @order.other = 1
      expect(@order.valid?).to eq(false)
    end
  end
  
  describe 'unpaidの切り替え' do
    it '費用全項目支払い済なら、falseとなる' do
      @order.update_attributes(wage_pay: true, cloth_pay: true, lining_pay: true, button_pay: true, postage_pay: true, other_pay: true)
      expect(@order.unpaid?).to eq(false)
    end
    
    it 'wage_payのみ未払いなら、trueとなる' do
      @order.update_attributes(wage_pay: false, cloth_pay: true, lining_pay: true, button_pay: true, postage_pay: true, other_pay: true)
      expect(@order.unpaid?).to eq(true)
    end
    
    it 'cloth_payのみ未払いなら、trueとなる' do
      @order.update_attributes(wage_pay: true, cloth_pay: false, lining_pay: true, button_pay: true, postage_pay: true, other_pay: true)
      expect(@order.unpaid?).to eq(true)
    end
    
    it 'lining_payのみ未払いなら、trueとなる' do
      @order.update_attributes(wage_pay: true, cloth_pay: true, lining_pay: false, button_pay: true, postage_pay: true, other_pay: true)
      expect(@order.unpaid?).to eq(true)
    end
    
    it 'button_payのみ未払いなら、trueとなる' do
      @order.update_attributes(wage_pay: true, cloth_pay: true, lining_pay: true, button_pay: false, postage_pay: true, other_pay: true)
      expect(@order.unpaid?).to eq(true)
    end
    
    it 'postage_payのみ未払いなら、trueとなる' do
      @order.update_attributes(wage_pay: true, cloth_pay: true, lining_pay: true, button_pay: true, postage_pay: false, other_pay: true)
      expect(@order.unpaid?).to eq(true)
    end
    
    it 'other_payのみ未払いなら、trueとなる' do
      @order.update_attributes(wage_pay: true, cloth_pay: true, lining_pay: true, button_pay: true, postage_pay: true, other_pay: false)
      expect(@order.unpaid?).to eq(true)
    end
  end
  
  describe 'tradedの切り替え' do
    it 'sold_onがあり、depositとretailが同値だと、trueとなる' do
      @order.update_attributes(sold_on: '2020-05-11', deposit: 100000)
      expect(@order.traded?).to eq(true)
    end
    
    it 'sold_onが空、depositとretailが同値だと、trueとなる' do
      @order.update_attributes(deposit: 100000)
      expect(@order.traded?).to eq(false)
    end
    
    it 'sold_onがあり、depositがretailより少ないと、trueとなる' do
      @order.update_attributes(sold_on: '2020-05-11',deposit: 99999)
      expect(@order.traded?).to eq(false)
    end
  end
end
