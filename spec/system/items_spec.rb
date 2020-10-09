require 'rails_helper'

# 商品出品テスト
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

# 商品編集テスト
RSpec.describe '出品商品編集', type: :system do
  before do
    # @item1 = FactoryBot.create(:item)
    # @item2 = FactoryBot.create(:item)
    @item1 = FactoryBot.build(:item)
    @item1.image = fixture_file_upload('sample.png')
    @item1.save
    @item2 = FactoryBot.build(:item)
    @item2.image = fixture_file_upload('sample.png')
    @item2.save
  end
  context '出品商品編集ができるとき' do
    it 'ログインしたユーザーは自分が出品した商品の編集ができる' do
      # 商品1を出品したユーザーでログインする
      visit new_user_session_path
      fill_in 'email', with: @item1.user.email
      fill_in 'password', with: @item1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 商品1の商品詳細ページへ遷移する
      # binding.pry
      visit item_path(@item1.id)
      # 商品1の商品詳細ページに「商品の編集」へのリンクがあることを確認する
      # binding.pry
      # expect(click_on '商品の編集').to eq edit_item_path(@item1.id)
      expect(page).to have_link '商品の編集', href: edit_item_path(@item1)
      # 商品編集ページへ遷移する
      visit edit_item_path(@item1.id)
      # すでに出品済みの内容がフォームに入っていることを確認する
      # binding.pry
      # expect(
      #   find('item-image').value
      # ).to eq @item1.image
      # expect(find('item[image]').value).to eq @item1.image
      # binding.pry
      expect(
        find('#item-name').value
      ).to eq @item1.goods
      expect(
        find('#item-info').value
      ).to eq @item1.details
      # binding.pry
      # expect(page).to have_select('#item-category', selected: @item1.category_id)
      expect(page).to have_select('item[category_id]', selected: @item1.category.name)
      # binding.pry
      expect(page).to have_select('item[status_id]', selected: @item1.status.name)
      expect(page).to have_select('item[shipping_fee_burden_id]', selected: @item1.shipping_fee_burden.name)
      expect(page).to have_select('item[shipping_area_id]', selected: @item1.shipping_area.name)
      expect(page).to have_select('item[days_to_ship_id]', selected: @item1.days_to_ship.name)
      expect(
        find('#item-price').value
      ).to eq @item1.price.to_s
      # 出品内容を編集する
      file_path = Rails.root.join('spec', 'fixtures', "sample.png")
      attach_file("item[image]", file_path)
      fill_in 'item-name', with: "#{@item1.goods}編集"
      fill_in 'item-info', with: "#{@item1.details}編集"
      select('メンズ', from: 'item-category')
      select('未使用に近い', from: 'item-sales-status')
      select('送料込み（出品者負担）', from: 'item-shipping-fee-status')
      select('茨城県', from: 'item-prefecture')
      select('4~7日で発送', from: 'item-scheduled-delivery')
      # binding.pry
      # 編集してもItemモデルのカウントは変わらないことを確認する
      expect {
        find('input[name="commit"]').click
      }.to change { Item.count }.by(0)
      # 商品1の商品詳細画面に遷移したことを確認する
      expect(current_path).to eq item_path(@item1.id)
      # visit item_path(@item1.id)
      # トップページに遷移する
      visit root_path
      # トップページには先ほど変更した内容の商品が存在することを確認する（画像）
      expect(page).to have_selector("img[src$='sample.png']")
      # トップページには先ほど変更した内容の商品が存在することを確認する（商品名）
      expect(page).to have_content(@item1.goods)
      # トップページには先ほど変更した内容の商品が存在することを確認する（価格）
      expect(page).to have_content(@item1.price)
    end
  end
  context '出品商品編集ができないとき' do
    it 'ログインしたユーザーは自分以外が出品した商品の編集画面には遷移できない' do
      # 商品1を出品したユーザーでログインする
      visit new_user_session_path
      fill_in 'email', with: @item1.user.email
      fill_in 'password', with: @item1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 商品2の商品詳細ページに遷移する
      visit item_path(@item2.id)
      # 商品2に「編集」ボタンがないことを確認する
      expect(page).to_not have_content '商品の編集'
    end
    it 'ログインしていないと出品した商品の編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # 商品1の商品詳細ページに遷移する
      visit item_path(@item1.id)
      # 商品1に「編集」ボタンがないことを確認する
      expect(page).to_not have_content '商品の編集'
      # 商品2の商品詳細ページに遷移する
      visit item_path(@item2.id)
      # 商品2に「編集」ボタンがないことを確認する
      expect(page).to_not have_content '商品の編集'
    end
  end
end

# 商品削除テスト
RSpec.describe '商品削除', type: :system do
  before do
    @item1 = FactoryBot.build(:item)
    @item1.image = fixture_file_upload('sample.png')
    @item1.save
    @item2 = FactoryBot.build(:item)
    @item2.image = fixture_file_upload('sample.jpg')
    @item2.save
  end

  context '商品削除ができるとき' do
    it 'ログインしたユーザーは自らが出品した商品の削除ができる' do
      # 商品1を出品したユーザーでログインする
      visit new_user_session_path
      fill_in 'email', with: @item1.user.email
      fill_in 'password', with: @item1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 商品1の詳細ページに遷移する
      visit item_path(@item1)
      # 商品1の詳細ページに「削除」ボタンがあることを確認する
      expect(page).to have_content('削除')
      # expect(page).to have_link '削除', href: item_path(@item1) #リンクの有無を確かめる必要はない
      # 商品を削除するとレコードの数が1減ることを確認する
      expect{find_link('削除', href: item_path(@item1)).click}.to change { Item.count }.by(-1)
      # expect(page).to have_link '商品の編集', href: edit_item_path(@item1)
      # トップページに遷移したことを確認する
      expect(current_path).to eq root_path
      # トップページには商品1の内容が存在しないことを確認する（画像）
      expect(page).to have_no_selector("img[src$='sample.png']")
      # トップページには商品1の内容が存在しないことを確認する（商品名）
      expect(page).to have_no_content(@item1.goods)
      # トップページには商品1の内容が存在しないことを確認する（価格）
      expect(page).to have_no_content(@item1.price)
    end
  end
  
  context '商品削除ができないとき' do
    it 'ログインしたユーザーは自分以外が出品した商品の削除ができない' do
      # 商品1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'email', with: @item1.user.email
      fill_in 'password', with: @item1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 商品2の詳細ページに遷移する
      visit item_path(@item2)
      # 商品2の詳細ページに「削除」ボタンが無いことを確認する
      expect(page).to have_no_content('削除')
      # expect(page).to have_no_link '削除', href: item_path(@item2)
    end
    it 'ログインしていないと商品の削除ボタンがない' do
      # トップページに移動する
      visit root_path
      # 商品1の詳細ページに遷移する
      visit item_path(@item1)
      # 商品1に「削除」ボタンが無いことを確認する
      expect(page).to have_no_content('削除')
      # トップページに移動する
      visit root_path
      # 商品2の詳細ページに遷移する
      visit item_path(@item2)
      # 商品2に「削除」ボタンが無いことを確認する
      expect(page).to have_no_content('削除')
    end
  end
end

