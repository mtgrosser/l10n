class ModelCar
  include ActiveModel::API
  include ActiveModel::Attributes
  
  attribute :price, :decimal
  attribute :speed, :float
end
