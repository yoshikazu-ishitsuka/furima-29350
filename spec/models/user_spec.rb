require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    describe 'ユーザー新規登録' do
      context '新規登録がうまくいくとき' do
        it 'nickname,email,password,password_confirmation, \
          last_name,first_name,last_name_kana,first_name_kana,birthdayが存在すれば登録できる' do
          expect(@user).to be_valid
        end
      end

      context '新規登録がうまくいかないとき' do
        it 'nicknameが空だと登録できない' do
          @user.nickname = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("ニックネームを入力してください")
        end
        it 'emailが空だと登録できない' do
          @user.email = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Eメールを入力してください")
        end
        it '重複したemailが存在する場合は登録できない' do
          @user.save
          another_user = FactoryBot.build(:user, email: @user.email)
          another_user.valid?
          expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
        end
        it 'emailに＠がない場合は登録できない' do
          @user.email = 'mail.gmail.com'
          @user.valid?
          expect(@user.errors.full_messages).to include('Eメールは不正な値です')
        end
        it 'passwordが空だと登録できない' do
          @user.password = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("パスワードを入力してください")
        end
        it 'passwordが5文字以下だと登録できない' do
          @user.password = 'abcd5'
          @user.password_confirmation = 'abcd5'
          @user.valid?
          expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
        end
        it 'passwordが数字のみだと登録できない' do
          @user.password = '111111'
          @user.password_confirmation = '111111'
          @user.valid?
          expect(@user.errors.full_messages).to include('パスワードは英字と数字の両方を含めて設定してください')
        end
        it 'passwordが英字のみだと登録できない' do
          @user.password = 'aaaaaa'
          @user.password_confirmation = 'aaaaaa'
          @user.valid?
          expect(@user.errors.full_messages).to include('パスワードは英字と数字の両方を含めて設定してください')
        end
        it 'passwordが存在してもpassword_confirmationが空だと登録できない' do
          @user.password_confirmation = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
        end
        it 'last_nameが空だと登録できない' do
          @user.last_name = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("苗字を入力してください")
        end
        it 'last_nameが全角以外だと登録できない' do
          @user.last_name = 'yamada'
          @user.valid?
          expect(@user.errors.full_messages).to include('苗字は全角（漢字・ひらがな・カタカナ）を使用してください')
        end
        it 'first_nameが空だと登録できない' do
          @user.first_name = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("名前を入力してください")
        end
        it 'first_nameが全角以外だと登録できない' do
          @user.first_name = 'rikutaro'
          @user.valid?
          expect(@user.errors.full_messages).to include('名前は全角（漢字・ひらがな・カタカナ）を使用してください')
        end
        it 'last_name_kanaが空だと登録できない' do
          @user.last_name_kana = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("苗字のフリガナを入力してください")
        end
        it 'last_name_kanaが全角カナ以外だと登録できない' do
          @user.last_name_kana = 'ﾔﾏﾀﾞ'
          @user.valid?
          expect(@user.errors.full_messages).to include('苗字のフリガナは全角（カタカナ）を使用してください')
        end
        it 'first_name_kanaが空だと登録できない' do
          @user.first_name_kana = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("名前のフリガナを入力してください")
        end
        it 'first_name_kanaが全角カナ以外だと登録できない' do
          @user.first_name_kana = 'ﾘｸﾀﾛｳ'
          @user.valid?
          expect(@user.errors.full_messages).to include('名前のフリガナは全角（カタカナ）を使用してください')
        end
        it 'birthdayが空だと登録できない' do
          @user.birthday = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("誕生日を入力してください")
        end
      end
    end
  end
end
