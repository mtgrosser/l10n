ActiveRecord::Migration.verbose = false

ActiveRecord::Schema.define do
  
  create_table :cars, :force => true do |t|
    t.string  :make
    t.string  :make_de
    t.string  :model
    t.string  :model_de
    t.string  :description
    t.string  :description_de
    t.decimal :price, :precision => 14, :scale => 2
    t.decimal :speed, :precision => 14, :scale => 4
  end
  
  create_table :trucks, :force => true do |t|
    t.string  :make
    t.string  :make_de
    t.string  :model
    t.string  :model_de
    t.string  :description
    t.string  :description_de
    t.decimal :price, :precision => 14, :scale => 2
    t.decimal :speed, :precision => 14, :scale => 4
  end
  
  create_table :airplanes, force: true do |t|
    t.string  :model
    t.decimal :wingspan, :precision => 14, :scale => 2
    t.decimal :payload,  :precision => 14, :scale => 2
  end

end
