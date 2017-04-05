class ModelAirplane
  include ActiveModel::Validations
  
  attr_accessor :wingspan
  attr_accessor :wingspan_before_type_cast
  
  validates :wingspan, numericality: { greater_than: 0, less_than: 5000 }
end