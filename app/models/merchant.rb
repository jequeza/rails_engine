class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :items

  def self.find_by_name(name)
    where("name ilike ?", "%#{name}%").order(name: :asc)
  end
end
