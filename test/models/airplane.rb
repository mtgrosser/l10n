class Airplane < ActiveRecord::Base
  validates :wingspan, numericality: { greater_than: 0, less_than: 100_000 }
  validates :payload, numericality: { only_integer: true }, allow_nil: true
end
