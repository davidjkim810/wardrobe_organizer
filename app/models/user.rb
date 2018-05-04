class User < ActiveRecord::Base
  has_many :wardrobes
  has_many :categories, through: :wardrobes
  has_secure_password
  validates_presence_of :username, :nickname, :password
  validates :username, uniqueness: true

end
