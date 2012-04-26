class User < ActiveRecord::Base
  validates :money, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}
  validates :name, :uniqueness => true, :presence => true

  attr_accessible :name, :money
end
