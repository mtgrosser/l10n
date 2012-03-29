class Car < ActiveRecord::Base
  attr_accessible :make, :model, :price, :speed, :make_t, :make_de, :model_t, :model_de
  
  validates :make_t, :model_t, :presence => true

  translates :make, :model  
end