# require 'rails_helper'

# # 商品購入機能テスト
# RSpec.describe "商品購入機能", type: :system do
#   before do
#     @order = FactoryBot.build(:order)
#     @user = FactoryBot.create(:user)
#     @item1 = FactoryBot.build(:item)
#     @item1.image = fixture_file_upload('sample.png')
#     @item1.save
#     @item2 = FactoryBot.build(:item)
#     @item2.image = fixture_file_upload('sample.jpg')
#     @item2.save
# end

#   context '商品購入ができるとき'do
#     it 'ログインしたユーザーは購入ができる' do
#       # ログインする
#       visit new_user_session_path
#       fill_in 'email', with: @user.email
#       fill_in 'password', with: @user.password
#       find('input[name="commit"]').click
#       expect(current_path).to eq root_path
#       # 商品1の商品詳細ページへ遷移する     ### 商品1でも2でも大丈夫だと思うが便宜上商品1で設定している
#       visit item_path(@item1)
#       # 購入画面へのリンクがあることを確認する
#       expect(page).to have_content('購入画面に進む')
#       # 商品1の購入ページへ遷移する
#       visit item_orders_path(@item1)
#       # 商品1の商品の説明があることを確認する
#       expect(page).to have_selector("img[src$='sample.png']")
#       expect(page).to have_content(@item1.details)
#       expect(page).to have_content(@item1.price)
#       # フォームに情報を入力する
#       fill_in 'card-number', with: @item.details
#       select('メンズ', from: 'item-category')
#       # 
#       # 
#       # 
#     end
#   end

#   context '商品購入ができないとき'do
#     it 'ログインしていないと商品購入ページに遷移できない' do
#       # トップページに遷移する
#       # 新規投稿ページへのリンクがない
#     end
#   end

# end
