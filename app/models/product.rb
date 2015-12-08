class Product < ActiveRecord::Base
  belongs_to :user
  has_many :orders
  has_many :reviews
  has_and_belongs_to_many :categories

  validates :name, :price, presence: true
  validates :name, uniqueness: true
  validates_numericality_of :price, :greater_than => 0
end
