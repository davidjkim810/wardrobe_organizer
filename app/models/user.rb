class User < ActiveRecord::Base
  has_many :wardrobes
  has_many :items, through: :wardrobes
  has_secure_password


  def slug
    self.username.downcase.gsub(' ',  '-').gsub(/[^\w-]/, '')
  end

  def self.find_by_slug(user_name)
    User.all.find do |user|
    user.username.downcase == user_name.gsub('-', ' ')
    end
  end


end
