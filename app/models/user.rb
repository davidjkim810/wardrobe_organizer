class User < ActiveRecord::Base
  has_many :wardrobes
  has_many :items, through: :wardrobes
  has_secure_password

end
