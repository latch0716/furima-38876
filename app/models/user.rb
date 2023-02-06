class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :items
  has_many :purchases

  validates :nickname, presence: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :birthdate, presence: true

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates :password, format: { with: VALID_PASSWORD_REGEX, message: 'is invalid. Incude both letters and numbers'}

  VALID_NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/.freeze
  validates :last_name, format: { with: VALID_NAME_REGEX, message: 'is invalid. Input full-width characters'}
  validates :first_name, format: { with: VALID_NAME_REGEX, message: 'is invalid. Input full-width characters'}

  VALID_NAME_KANA_REGEX = /\A[ァ-ヶー]+\z/.freeze
  validates :last_name_kana, format: { with: VALID_NAME_KANA_REGEX, message: 'is invalid. Input full-width katakana characters'}
  validates :first_name_kana, format: { with: VALID_NAME_KANA_REGEX, message: 'is invalid. Input full-width katakana characters'}
end
