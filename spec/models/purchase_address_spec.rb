require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @purchase_address = FactoryBot.build(:purchase_address, user_id: @user.id, item_id: @item.id)
    sleep 0.1
  end

  describe '商品購入' do
    context '商品が購入できるとき' do
      it '全ての項目が存在するとき購入できる' do
        expect(@purchase_address).to be_valid
      end
      it '建物名が空でも購入できる' do
        @purchase_address.building = ''
        expect(@purchase_address).to be_valid
      end
    end
    context '商品が購入できないとき' do
      it '郵便番号が空では購入できない' do
        @purchase_address.postalcode = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("郵便番号を入力してください")
      end
      it '都道府県が未選択では購入できない' do
        @purchase_address.prefecture_id = 1
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("都道府県を選択してください")
      end
      it '市区町村が空では購入できない' do
        @purchase_address.city = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("市区町村を入力してください")
      end
      it '番地が空では購入できない' do
        @purchase_address.block = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("番地を入力してください")
      end
      it '電話番号が空では購入できない' do
        @purchase_address.phone_number = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("電話番号を入力してください")
      end
      it 'tokenが空では購入できない' do
        @purchase_address.token = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("正しいクレジットカード情報を入力してください")
      end
      it '郵便番号が「3桁ハイフン4桁」かつ半角数字でないと購入できない' do
        @purchase_address.postalcode = '123-456'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("郵便番号をハイフン（-）をつけて入力してください")
      end
      it '郵便番号が半角ハイフンを含む形でなければ購入できない' do
        @purchase_address.postalcode = '1234567'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("郵便番号をハイフン（-）をつけて入力してください")
      end
      it '電話番号が9桁以下では購入できない' do
        @purchase_address.phone_number = '090123456'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('電話番号は不正な値です')
      end
      it '電話番号が12桁以上では購入できない' do
        @purchase_address.phone_number = '090123456789'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('電話番号は不正な値です')
      end
      it '電話番号が半角数字以外では購入できない' do
        @purchase_address.phone_number = '０９０１２３４５６７８'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('電話番号は不正な値です')
      end
      it 'user_idが紐付いていなければ購入できない' do
        @purchase_address.user_id = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Userを入力してください")
      end
      it 'item_idが紐付いていなければ購入できない' do
        @purchase_address.item_id = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Itemを入力してください")
      end
    end
  end
end
