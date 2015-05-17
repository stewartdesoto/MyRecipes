class Recipe < ActiveRecord::Base
  belongs_to :chef
  validates :chef_id, presence: true
  validates :name, presence: true, length: {minimum: 2, maximum: 100}
  validates :summary, presence: true
  
end