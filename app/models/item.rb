class Item < ApplicationRecord
  has_one_attached :image
   belongs_to :user

  validates :name, presence:true
  validates :description, presence:true,length:{maximum:200}
end

