class Car < ActiveRecord::Base
  validates :make_t, :model_t, :presence => true

  translates :make, :model  
end
