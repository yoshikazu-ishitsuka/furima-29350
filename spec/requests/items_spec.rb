require 'rails_helper'
# テストコード実行時はapplication_controllerのBasicAuthを解除すること

RSpec.describe "ItemsController", type: :request do
  # let(:user) { create(:user) }
  # let(:item) { create(:item) }
  before(:each) do
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


  describe "GET /items" do
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
      expect(response.body).to include 'sample.png'
    end
    # it 'indexアクションにリクエストするとレスポンスに出品済みの商品の販売価格が存在する' do
    #   get root_path
    #   expect(response).to render_template :index
    # end
    #   it '@user' do
    #     get :index
    #     expect(assigns :users).to eq users
    #   end

  end
end
