class CombineItemsInCart < ActiveRecord::Migration[5.2]

  def self.up
    Cart.all.each do |cart|
      sums = cart.line_items.group(:product_id).sum(:quantity)
      sums.each do |product_id, quantity|
        if quantity > 1
          # remove individual items
          cart.line_items.where(:product_id=>product_id).delete_all

          # replace with single item
          cart.line_items.create(:product_id=>product_id, :quantity=>quantity)
        end #if
      end  #sums.each do
    end #Cart.all.each
  end #self.up

  def self.down
    #split items with quantity > 1 into multiple items
    LineItem.where("quantity>1").each do |lineitem|
      #add individual items
      lineitem.quantity.times do
        LineItem.create :cart_id=>lineitem.cart_id, :product_id=>lineitem.product_id, :quantity=>1
      end #lineitem.quantity.times do
      #remove original item
      lineitem.destroy
    end #LineItem.where("quantity>1").each do
  end #self.down

end
