require 'rails_helper'
# テストコード実行時はapplication_controllerのBasicAuthをコメントアウトすること
# テストコード実行時はbefore_action :authenticate_user!をコメントアウトすること

RSpec.describe 'OrdersController', type: :request do
  before do
    # @user_order = FactoryBot.build(:user_order)
    @user = FactoryBot.create(:user)
    # @user2 = FactoryBot.create(:user)
    @item = FactoryBot.build(:item)
    @item.image = fixture_file_upload('sample.png')
    @item.save
    # @item2 = FactoryBot.build(:item)
    # @item2.image = fixture_file_upload('sample.png')
    # @item2.save
    # @order = FactoryBot.build(:order)
  end

  describe "GET /index" do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
      # binding.pry
      get item_orders_path(@item)
      # binding.pry
      expect(response.status).to eq 200
    end
    it 'indexアクションにリクエストするとレスポンスに出品済みの商品の説明文が存在する' do
      get item_orders_path(@item)
      # binding.pry
      expect(response.body).to include @item.details
    end
    it 'indexアクションにリクエストするとレスポンスに出品済みの商品の画像が存在する' do
      get item_orders_path(@item)
      # binding.pry
      expect(response.body).to include 'sample.png'
    end
    it 'indexアクションにリクエストするとレスポンスに出品済みの商品の販売価格が存在する' do
      get item_orders_path(@item)
      expect(response.body).to include @item.price.to_s
    end
    
    it 'indexアクションにリクエストするとレスポンスに購入内容の確認の文言が存在する' do
      get item_orders_path(@item)
      expect(response.body).to include '購入内容の確認'
    end
  
  end

end
