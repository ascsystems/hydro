class AddInvoiceNumberAndStatusToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :invoice_number, :integer
    add_column :orders, :status, :string
  end
end
