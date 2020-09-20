require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#create' do
    before do
      @item = FactoryBot.build(:item)
      @item.image = fixture_file_upload('sample.png')
    end

    describe '商品出品登録' do
      context '商品出品登録がうまくいくとき' do
        it 'goods,details,category_id,status_id,shipping_fee_burden_id,shipping_area_id, \
            days_to_ship_id,price,user_idが存在すれば登録できる' do
            expect(@item).to be_valid
        end
        it 'imageが存在すれば登録できる' do
          expect(@item).to be_valid
        end
      end
      context '商品出品登録がうまくいかないとき' do
        it 'imageが空だと登録できない' do
          @item.image = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("Image can't be blank")
        end
        it 'goodsが空だと登録できない' do
          @item.goods = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Goods can't be blank")
        end
        it 'detailsが空だと登録できない' do
          @item.details = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Details can't be blank")
        end
        it 'category_idが空だと登録できない' do
          @item.category_id = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Category is not a number")
        end
        
        it 'status_idが空だと登録できない' do
          @item.status_id = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Status is not a number")
        end
        
        it 'shipping_fee_burden_idが空だと登録できない' do
          @item.shipping_fee_burden_id = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Shipping fee burden is not a number")
        end
        it 'shipping_area_idが空だと登録できない' do
          @item.shipping_area_id = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Shipping area is not a number")
        end
        it 'days_to_ship_idが空だと登録できない' do
          @item.days_to_ship_id = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Days to ship is not a number")
        end
        it 'priceが空だと登録できない' do
          @item.price = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Price can't be blank")
        end
        it 'priceが¥300より小さいと登録できない' do
          @item.price = '299'
          @item.valid?
          expect(@item.errors.full_messages).to include("Price 適正な販売価格を入力してください")
        end
        it 'priceが¥9,999,999より大きいと登録できない' do
          @item.price = '10,000,000'
          @item.valid?
          expect(@item.errors.full_messages).to include("Price 適正な販売価格を入力してください")
        end
        it 'priceが全角数字だと登録できない' do
          @item.price = '３００'
          @item.valid?
          expect(@item.errors.full_messages).to include("Price 適正な販売価格を入力してください")
        end
        it 'ユーザーが紐付いていないと登録できない' do
          @item.user = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("User must exist")
        end
      end
      
    end
  end
end
