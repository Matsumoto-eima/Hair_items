class Item < ApplicationRecord
  has_one_attached :image
   belongs_to :user
   has_many :item_comments, dependent: :destroy
   has_many :favorites, dependent: :destroy
  validates :category, presence: true
  validates :name, presence:true
  validates :description, presence:true,length:{maximum:200}

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end

