require 'rails_helper'

RSpec.describe "Merchants Revenue API" do
  it "returns a variable number of merchants ranked by total revenue" do
    merchants = create_list(:merchant, 20)
    customer = create(:customer)
    merchant1 = create(:merchant)
    merchant1_items = create_list(:item, 3, merchant_id: merchant1.id, unit_price: 5)
    merchant2 = create(:merchant)
    merchant2_items = create_list(:item, 3, merchant_id: merchant2.id, unit_price: 1)
    most_revenue_invoices = create_list(:invoice, 3, customer_id: customer.id, merchant_id: merchant1.id, status: 1)
    least_revenue_invoices = create_list(:invoice, 3, customer_id: customer.id, merchant_id: merchant2.id, status: 1)
    most_revenue_transaction1 = create(:transaction, invoice_id: most_revenue_invoices.first.id, result: 1)
    most_revenue_transaction1 = create(:transaction, invoice_id: most_revenue_invoices.second.id, result: 1)
    most_revenue_transaction1 = create(:transaction, invoice_id: most_revenue_invoices.third.id, result: 1)
    least_revenue_transaction1 = create(:transaction, invoice_id: least_revenue_invoices.first.id, result: 1)
    least_revenue_transaction1 = create(:transaction, invoice_id: least_revenue_invoices.second.id, result: 1)
    least_revenue_transaction1 = create(:transaction, invoice_id: least_revenue_invoices.third.id, result: 1)
    invoice_item1 = create(:invoice_item, item_id: merchant1_items.first.id, invoice_id: most_revenue_invoices.first.id)
    invoice_item2 = create(:invoice_item, item_id: merchant1_items.second.id, invoice_id: most_revenue_invoices.second.id)
    invoice_item3 = create(:invoice_item, item_id: merchant1_items.third.id, invoice_id: most_revenue_invoices.third.id)
    invoice_item4 = create(:invoice_item, item_id: merchant2_items.first.id, invoice_id: least_revenue_invoices.first.id)
    invoice_item5 = create(:invoice_item, item_id: merchant2_items.second.id, invoice_id: least_revenue_invoices.second.id)
    invoice_item6 = create(:invoice_item, item_id: merchant2_items.third.id, invoice_id: least_revenue_invoices.third.id)

    amount = 12

    get "/api/v1/merchants/most_revenue?quantity=#{amount}"

  end
end