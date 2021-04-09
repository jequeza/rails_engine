class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :items

  def self.find_by_name(name)
    where("name ilike ?", "%#{name}%").order(name: :asc)
  end

  def self.find_by_total_revenue(amount)
    joins(invoices: [:transactions, :invoice_items])
    .where("transactions.result = 0")
    .select("merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as total_revenue")
    .group(:id)
    .order(total_revenue: :desc)
    .limit(amount)
  end
end
