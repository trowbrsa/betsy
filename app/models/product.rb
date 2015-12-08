class Product < ActiveRecord::Base
  belongs_to :user
  has_many :orders
  has_many :reviews
  has_and_belongs_to_many :categories
end
