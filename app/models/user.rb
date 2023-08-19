class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :items, dependent: :destroy
         has_many :item_comments, dependent: :destroy
         has_many :favorites, dependent: :destroy
         has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
         has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
         has_many :following_user, through: :follower, source: :followed # 自分がフォローしている人
         has_many :follower_user, through: :followed, source: :follower # 自分をフォローしている人

         # ユーザーをフォローする
  def follow(user)
    follower.create(followed_id: user.id)
  end

  # ユーザーのフォローを外す
  def unfollow(user)
    follower.find_by(followed_id: user.id).destroy
  end

  # フォローしていればtrueを返す
  def following?(user)
    following_user.include?(user)
  end
end
