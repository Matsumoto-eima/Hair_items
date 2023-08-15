class Item < ApplicationRecord
  has_one_attached :image
   belongs_to :user
   has_many :item_comments, dependent: :destroy

  validates :name, presence:true
  validates :description, presence:true,length:{maximum:200}
end

