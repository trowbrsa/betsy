class Cart
 #Get subtotal of the cart items

 def self.subtotal(cart)
   subtotal = 0
   cart.each do |product, quantity|
     price = Product.find(product).price
     subtotal += (price * quantity)
   end
   return subtotal
 end


end
