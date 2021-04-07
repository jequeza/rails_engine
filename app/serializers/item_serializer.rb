class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :unit_price, :description, :merchant_id
end