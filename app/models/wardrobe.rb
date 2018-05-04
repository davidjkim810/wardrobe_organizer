class Wardrobe < ActiveRecord::Base
  belongs_to :user
  has_many :categories
  has_many :items, through: :categories

end
