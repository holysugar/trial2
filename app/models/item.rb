class Item < ActiveRecord::Base
  validates :name, :uniqueness => true
  validates :kind, :inclusion => (1..3)
end
