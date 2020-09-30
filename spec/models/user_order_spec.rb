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
          expect(@user_order.errors.full_messages).to include("郵便番号を入力してください")
        end
        it 'postal_codeがハイフンが無いと登録できない' do
          @user_order.postal_code = '1234567'
          @user_order.valid?
          expect(@user_order.errors.full_messages).to include('郵便番号は不正な値です')
        end
        it 'postal_codeが整数以外だと登録できない' do
          @user_order.postal_code = 'あああ-ああああ'
          @user_order.valid?
          expect(@user_order.errors.full_messages).to include('郵便番号は不正な値です')
        end
        it 'prefecture_idが空だと登録できない' do
          @user_order.prefecture_id = ''
          @user_order.valid?
          expect(@user_order.errors.full_messages).to include('都道府県を入力してください')
        end
        it 'prefecture_idが"---"だと登録できない' do
          @user_order.prefecture_id = '---'
          @user_order.valid?
          expect(@user_order.errors.full_messages).to include('都道府県は数値で入力してください')
        end
        it 'city_nameが空だと登録できない' do
          @user_order.city_name = ''
          @user_order.valid?
          expect(@user_order.errors.full_messages).to include("市区町村を入力してください")
        end
        it 'addressが空だと登録できない' do
          @user_order.address = ''
          @user_order.valid?
          expect(@user_order.errors.full_messages).to include("番地を入力してください")
        end
        it 'phone_numberが空だと登録できない' do
          @user_order.phone_number = ''
          @user_order.valid?
          expect(@user_order.errors.full_messages).to include("電話番号を入力してください")
        end
        it 'phone_numberが整数以外だと登録できない' do
          @user_order.phone_number = 'あああああああああああ'
          @user_order.valid?
          expect(@user_order.errors.full_messages).to include('電話番号は不正な値です')
        end
        it 'phone_numberにハイフンがあると登録できない' do
          @user_order.phone_number = '03-123-4567'
          @user_order.valid?
          expect(@user_order.errors.full_messages).to include('電話番号はハイフン無しで登録してください')
        end
        it 'phone_numberが12桁以上だと登録できない' do
          @user_order.phone_number = '090123456789'
          @user_order.valid?
          expect(@user_order.errors.full_messages).to include('電話番号は11文字以内で入力してください')
        end
        it 'tokenが空だと購入できない' do
          @user_order.token = ''
          @user_order.valid?
          expect(@user_order.errors.full_messages).to include("クレジットカード情報を入力してください")
        end
      end
    end
  end
end
