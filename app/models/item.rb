class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items

  def self.find_by_name(name)
    where("name ilike ?", "%#{name}%").order(name: :asc).limit(1)
  end
end
