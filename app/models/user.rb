class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many  :books,         dependent: :destroy
  has_many  :favorites,     dependent: :destroy
  has_many  :book_comments, dependent: :destroy
  
  # ① フォローしている人取得(Userのfollowerから見た関係)
  has_many  :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # ② フォローされている人取得(Userのfolowedから見た関係)
  has_many  :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 自分がフォローしている人
  has_many  :following_user, through: :follower, source: :followed
  # 自分をフォローしている人(自分がフォローされている人)
  has_many  :follower_user, through: :followed, source: :follower
  
  attachment :profile_image

  validates :name, presence: true, length: {minimum: 2, maximum: 20},uniqueness: true
  validates :introduction,length: {maximum: 50}
end