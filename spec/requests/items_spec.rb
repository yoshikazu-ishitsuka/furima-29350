require 'rails_helper'
# テストコード実行時はapplication_controllerのBasicAuthをコメントアウトすること

RSpec.describe "ItemsController", type: :request do
  # let(:user) { create(:user) }
  # let(:item) { create(:item) }
  before do
    # config.include ActionDispatch::TestProcess
    @item = FactoryBot.build(:item)
    # @item.image = fixture_file_upload('sample.jpg')
    @item.image = fixture_file_upload('sample.png')
    @item.save
    # @item.image = fixture_file_upload('./fixtures/sample.png', 'image/png')
    # @request.ENV ||= {}
    # user = "user"
    # pass = "admin"
    # @request.ENV['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pass)
  end


  describe "GET /index" do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
      # login user
      # get :new
      # expect(response).to render_template :new
      get root_path
      # binding.pry
      expect(response.status).to eq 200
      # get items_path
      # binding.pry
    end

    it 'indexアクションにリクエストするとレスポンスに出品済みの商品名が存在する' do
      get root_path
      expect(response.body).to include @item.goods
    end
    it 'indexアクションにリクエストするとレスポンスに出品済みの商品の画像が存在する' do
      get root_path
      # binding.pry
      expect(response.body).to include 'sample.png'
    end
    it 'indexアクションにリクエストするとレスポンスに出品済みの商品の販売価格が存在する' do
      get root_path
      expect(response.body).to include @item.price.to_s
    # end
    #   it '@user' do
    #     get :index
    #     expect(assigns :users).to eq users
    end
    
    it 'indexアクションにリクエストするとレスポンスに新規投稿商品一覧が存在する' do
      get root_path
      expect(response.body).to include '新規投稿商品'
    end
  
  end

  describe "GET #show" do
    it "showアクションにリクエストすると正常にレスポンスが返ってくる" do 
      get item_path(@item)
      expect(response.status).to eq 200
    end
    it "showアクションにリクエストするとレスポンスに出品済みの商品の商品名が存在する" do 
      get item_path(@item)
      expect(response.body).to include @item.goods
    end
    it "showアクションにリクエストするとレスポンスに出品済みの商品の画像が存在する" do 
      get item_path(@item)
      expect(response.body).to include 'sample.png'
    end
    it "showアクションにリクエストするとレスポンスに出品済みの商品の価格が存在する" do 
      get item_path(@item)
      expect(response.body).to include @item.price.to_s
    end
    it "showアクションにリクエストするとレスポンスに出品済みの商品の商品説明が存在する" do 
      get item_path(@item)
      expect(response.body).to include @item.details
    end
    it "showアクションにリクエストするとレスポンスにコメント入力欄が存在する" do 
      get item_path(@item)
      expect(response.body).to include 'コメントする'
    end
  end 

end
