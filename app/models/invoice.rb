class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items
  enum status: { packaged: 0, shipped: 1, returned: 2}
end
