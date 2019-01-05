class Category < ActiveRecord::Base

  has_and_belongs_to_many :questions, :uniq => true

  validates :name, :presence => true, :uniqueness => true

end

