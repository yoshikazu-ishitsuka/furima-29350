require 'rails_helper'

# 商品購入機能テスト
RSpec.describe "商品購入機能", type: :system do
  before do
    @user_order = FactoryBot.build(:user_order)
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    @item1 = FactoryBot.build(:item)
    @item1.image = fixture_file_upload('sample.png')
    @item1.save
    @item2 = FactoryBot.build(:item)
    @item2.image = fixture_file_upload('sample.jpg')
    @item2.save
end

  context '商品購入ができるとき'do
    it 'ログインしたユーザーは商品の購入ができる' do
      # user1でログインする
      sign_in(@user1)
      # visit new_user_session_path
      # fill_in 'email', with: @user1.email
      # fill_in 'password', with: @user1.password
      # find('input[name="commit"]').click
      # expect(current_path).to eq root_path
      # 商品1の商品詳細ページへ遷移する     ### 商品1でも2でも大丈夫だと思うが便宜上商品1で設定している
      visit item_path(@item1)
      # 購入画面へのリンクがあることを確認する
      expect(page).to have_content('購入画面に進む')
      # 商品1の購入ページへ遷移する
      visit item_orders_path(@item1)
      # 商品1の商品の説明があることを確認する
      expect(page).to have_selector("img[src$='sample.png']")
      expect(page).to have_content(@item1.details)
      expect(page).to have_content(@item1.price)
      # フォームに情報を入力する
      fill_in 'card-number', with: '4242424242424242'
      fill_in 'card-exp-month', with: '3'
      fill_in 'card-exp-year', with: '23'
      fill_in 'card-cvc', with: '123'
      # @user_order.token = FactoryBot.build(:user_order)
      fill_in 'postal-code', with: @user_order.postal_code
      select('北海道', from: 'prefecture')
      fill_in 'city', with: @user_order.city_name
      fill_in 'addresses', with: @user_order.address
      fill_in 'phone-number', with: @user_order.phone_number
      # 送信するとOrderモデルのカウントが1上がることを確認する
      expect {
        find('input[name="commit"]').click
        sleep 1.5
      }.to change { Order.count }.by(1)
      # sleep(1)
      # find('input[name="commit"]').click
      # sleep(1.5)
      # expect(Order.count).to eq 1
      # expect {find('input[name="commit"]').click}.to change { Order.count }.by(1)
      # トップページに戻っていることを確認する
      # binding.pry
      expect(current_path).to eq root_path
      # 購入した商品にSold Out!!の文字があることを確認する
      expect(page).to have_content('Sold Out!!')
      # 購入した商品の詳細ページに遷移しても購入ボタンが無いことを確認する
      visit item_path(@item1)
      expect(page).to have_no_content('購入画面に進む')
      # ログアウトする
      find_link('ログアウト', href: destroy_user_session_path).click
      # user2でログインする
      sign_in(@user2)
      # visit new_user_session_path
      # fill_in 'email', with: @user2.email
      # fill_in 'password', with: @user2.password
      # find('input[name="commit"]').click
      # expect(current_path).to eq root_path
      # 購入済みの商品詳細ページに遷移する
      visit item_path(@item1)
      # 購入ボタンが無いことを確認する
      expect(page).to have_no_content('購入画面に進む')
    end
  end

  context '商品購入ができないとき'do
    it 'ログインしていないと商品購入ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 商品1の商品詳細ページへ遷移する
      visit item_path(@item1)
      # 購入ボタンが無いことを確認する
      expect(page).to have_no_content('購入画面に進む')
      # トップページに戻る
      visit root_path
      # 商品2の商品詳細ページへ遷移する
      visit item_path(@item2)
      # 購入ボタンが無いことを確認する
      expect(page).to have_no_content('購入画面に進む')
    end
  end

end
