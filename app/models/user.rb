class User < ActiveRecord::Base
  has_many :wardrobes
  has_many :categories, through: :wardrobes
  has_secure_password

end
