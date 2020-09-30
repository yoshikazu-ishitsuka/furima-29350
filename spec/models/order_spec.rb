require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#create' do
    before do
      @order = FactoryBot.build(:order)
    end

    describe '商品購入登録' do
      context '商品購入登録がうまくいくとき' do
        it 'user_id,item_idが存在すれば登録できる' do
          expect(@order).to be_valid
        end
      end
      context '商品購入登録がうまくいかないとき' do
        it 'ユーザーが紐付いていないと登録できない' do
          @order.user = nil
          @order.valid?
          expect(@order.errors.full_messages).to include('ユーザーを入力してください')
        end
        it '商品が紐付いていないと登録できない' do
          @order.item = nil
          @order.valid?
          expect(@order.errors.full_messages).to include('商品を入力してください')
        end
      end
    end
  end
end
