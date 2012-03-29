class Car < ActiveRecord::Base
  validates :make, :model, presence: true

  translates :make, :model  
end