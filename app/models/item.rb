class Item < ActiveRecord::Base
  validates :price, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}
  validates :name, :uniqueness => true, :presence => true
  validates :kind, :inclusion => (1..3)
end
