class Wardrobe < ActiveRecord::Base
  belongs_to :user
  has_many :categories
  has_many :items

  def slug
    self.name.downcase.gsub(' ',  '-').gsub(/[^\w-]/, '')
  end

  def self.find_by_slug(name)
    Wardrobe.all.find do |wardrobe|
    wardrobe.name.downcase == name.gsub('-', ' ')
    end
  end


end
