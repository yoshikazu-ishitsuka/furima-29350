class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :orders

  validates :nickname, presence: true

  VALID_EMAIL_REGEX = /.+@.+/.freeze
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates :password, presence: true, length: { minimum: 6 }, confirmation: true, \
                       format: { with: PASSWORD_REGEX, message: '英字と数字の両方を含めて設定してください' }

  with_options presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: '全角（漢字・ひらがな・カタカナ）を使用してください' } do
    validates :last_name
    validates :first_name
  end

  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ン]+\z/, message: '全角（カタカナ）を使用してください' }
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ン]+\z/, message: '全角（カタカナ）を使用してください' }

  validates :birthday, presence: true
end
