class Item < ActiveRecord::Base
  belongs_to :wardrobe
  belongs_to :brand

end
