class Cart

  def initialize(session)
   @session = session
   @session[:cart] ||= {}
  end

  def add_product(product_id, quantity)
    initialize
    @session[:cart] = {:product_id => quantity }
  end


 def cart_count
   if @session[:cart]!= {}
       return @session[:cart].count
   else
      return 0
   end
 end

  #return an array of product objects that are in the cart
  def find_products
    product = []
    order_items = new_order_items
    order_items.each do |order_item|
      product = Product.find(order_item.product_id)
      products.push(product)
    end
    return products
  end

 #Get subtotal of the cart items

 def subtotal
   subtotal = 0
   @session[:cart].each do |product, quantity|
     price = Product.find(product).price
     subtotal += (price * quantity)
   end
   return subtotal
 end


end
