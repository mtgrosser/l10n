class Truck < ActiveRecord::Base
  attr_accessible :make, :model, :price, :speed, :make_t, :make_de, :model_t, :model_de, :make_translations, :model_translations
  
  translates :make, :model
  
  validates_translation_of :model
end