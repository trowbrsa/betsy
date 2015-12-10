module ApplicationHelper
  def dollar_price(amount)
    number_to_currency(amount / 100.0)
  end
end
