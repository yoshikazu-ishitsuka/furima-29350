require 'rails_helper'

RSpec.describe "商品出品機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item)
    # @item.image = Faker::Lorem.sentence
    # @item.image = fixture_file_upload('sample.png')
  end
  context '商品出品が出来るとき' do
    it 'ログインしたユーザーは商品出品が出来る' do
      # ログインする
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 商品出品ページへのリンクがあることを確認する
      expect(page).to have_content('出品する')
      # 商品出品ページに移動する
      visit new_item_path
      # フォームに情報を入力する
      file_path = Rails.root.join('spec', 'fixtures', "sample.jpg")
      attach_file("item[image]", file_path) # (make_visible: true)が必要な場合も時にはある[cssにdisplay:none]ある時
      # attach_file("item-image", '../fixtures/sample.jpg')
      fill_in 'item-name', with: @item.goods
      fill_in 'item-info', with: @item.details
      select('メンズ', from: 'item-category')
      select('新品、未使用', from: 'item-sales-status')
      select('送料込み（出品者負担）', from: 'item-shipping-fee-status')
      select('北海道', from: 'item-prefecture')
      select('1~2日で発送', from: 'item-scheduled-delivery')
      fill_in 'item-price', with: @item.price
      # 送信するとItemモデルのカウントが1上がることを確認する
      expect {
        find('input[name="commit"]').click
      }.to change { Item.count }.by(1)
      # トップページに遷移する
      visit root_path
      # トップページには先程出品した内容の画像が存在することを確認する(image)
      # binding.pry
      expect(page).to have_selector("img[src$='sample.jpg']")
      # expect(page).to have_selector  ".item-img-content"
      # expect(page).to have_content("sample.jpg")
      # link = find('.item-img-content')
      # expect(link[:href]).to eq file_path
      # トップページには先程出品した内容の商品名が存在することを確認する(goods)
      expect(page).to have_content(@item.goods)
      # トップページには先程出品した内容の値段が存在することを確認する(price)
      expect(page).to have_content(@item.price)
    end
  end
  context '商品出品が出来ないとき' do
    it 'ログインしていないと商品出品ページに遷移出来ない' do
      # トップページに遷移する
      visit root_path
      # 商品出品ページへのリンクがあることを確認する
      expect(page).to have_content('出品する')
      # 商品出品ページに移動するリンクをクリックするとトップページに戻る
      # click_link 'camera.png'
      visit new_item_path
      # "img[src$='sample.jpg']"
      # find('img[src$='camera.png']').click
      expect(current_path).to eq new_user_session_path
    end
  end
end
