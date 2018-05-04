class Category < ActiveRecord::Base
  belongs_to :wardrobe
  has_many :items
end
