class AddEcommerceToProduct < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :ecommerce, :boolean, default: true
  end
end
