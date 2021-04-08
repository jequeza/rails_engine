class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items

  def self.find_by_name(name)
    where("name ilike ?", "%#{name}%").order(name: :asc)
  end
  def self.find_by_price(price)
    format_price = price.to_f
    where("unit_price >= ?", format_price).order(unit_price: :asc)
  end
end
