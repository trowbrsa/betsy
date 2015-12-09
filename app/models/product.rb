class Product < ActiveRecord::Base
  belongs_to :user
  has_many :orders
  has_many :reviews
  has_and_belongs_to_many :categories

  validates :name, :price, presence: true
  validates :name, uniqueness: true
  validates_numericality_of :price, :greater_than => 0
  validates :photo_url, format: {with: /\.(png|jpg)\Z/i}, allow_nil: true

end
