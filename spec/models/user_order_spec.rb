require 'rails_helper'

RSpec.describe UserOrder, type: :model do
  describe '#create' do
    before do
      @user_order = FactoryBot.build(:user_order)
    end

    describe '商品配送先登録' do
      context '商品配送先登録がうまくいくとき' do
        it 'token,postal_code,prefecture_id,city_name,address,phone_number,order_idが存在すれば登録できる' do
          expect(@user_order).to be_valid
        end
      end

      context '商品配送先登録がうまくいかないとき' do
        it 'postal_codeが空だと登録できない' do
          @user_order.postal_code = ''
          @user_order.valid?
          expect(@user_order.errors.full_messages).to include("Postal code can't be blank")
        end
        it 'postal_codeがハイフンが無いと登録できない' do
          @user_order.postal_code = '1234567'
          @user_order.valid?
          expect(@user_order.errors.full_messages).to include('Postal code is invalid')
        end
        it 'postal_codeが整数以外だと登録できない' do
          @user_order.postal_code = 'あああ-ああああ'
          @user_order.valid?
          expect(@user_order.errors.full_messages).to include('Postal code is invalid')
        end
        it 'prefecture_idが空だと登録できない' do
          @user_order.prefecture_id = ''
          @user_order.valid?
          expect(@user_order.errors.full_messages).to include('Prefecture is not a number')
        end
        it 'prefecture_idが"---"だと登録できない' do
          @user_order.prefecture_id = '---'
          @user_order.valid?
          expect(@user_order.errors.full_messages).to include('Prefecture is not a number')
        end
        it 'city_nameが空だと登録できない' do
          @user_order.city_name = ''
          @user_order.valid?
          expect(@user_order.errors.full_messages).to include("City name can't be blank")
        end
        it 'addressが空だと登録できない' do
          @user_order.address = ''
          @user_order.valid?
          expect(@user_order.errors.full_messages).to include("Address can't be blank")
        end
        it 'phone_numberが空だと登録できない' do
          @user_order.phone_number = ''
          @user_order.valid?
          expect(@user_order.errors.full_messages).to include("Phone number can't be blank")
        end
        it 'phone_numberが整数以外だと登録できない' do
          @user_order.phone_number = 'あああああああああああ'
          @user_order.valid?
          expect(@user_order.errors.full_messages).to include('Phone number is invalid')
        end
        it 'phone_numberにハイフンがあると登録できない' do
          @user_order.phone_number = '03-123-4567'
          @user_order.valid?
          expect(@user_order.errors.full_messages).to include('Phone number is not a number')
        end
        it 'phone_numberが12桁以上だと登録できない' do
          @user_order.phone_number = '090123456789'
          @user_order.valid?
          expect(@user_order.errors.full_messages).to include('Phone number is too long (maximum is 11 characters)')
        end
        it 'tokenが空だと購入できない' do
          @user_order.token = ''
          @user_order.valid?
          expect(@user_order.errors.full_messages).to include("Token can't be blank")
        end
      end
    end
  end
end
