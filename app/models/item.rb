class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items

  def self.find_by_name(name)
    where("name ilike ?", "%#{name}%").order(name: :asc)
  end

  def self.find_by_min_price(price)
    format_price = price.to_f
    where("unit_price >= ?", format_price).order(name: :asc)
  end

  def self.find_by_max_price(price)
    format_price = price.to_f
    where("unit_price <= ?", format_price).order(name: :asc)
  end

  def self.find_by_price_range(min_price, max_price)
    format_max_price = max_price.to_f
    format_min_price = min_price.to_f
    where("unit_price >= ? and unit_price <= ?", "#{format_min_price}", "#{format_max_price}")
    .distinct
    .order(name: :asc)
  end
end