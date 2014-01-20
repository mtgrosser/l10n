class Truck < ActiveRecord::Base
  translates :make, :model
  
  validates_translation_of :model
end
