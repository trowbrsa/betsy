class Cart

 def self.subtotal(cart)
   subtotal = 0
   cart.each do |product, quantity|
     price = Product.find(product).price.to_i
     subtotal += (price * quantity)
   end
   return subtotal
 end


end
