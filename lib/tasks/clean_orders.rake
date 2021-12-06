namespace :clean_orders do
  desc "delete empty orders than 12 hours"
  task delete_empty_orders: :environment do
    Order.left_outer_joins(:items).where(items: {id: nil}).destroy_all

  end

end
