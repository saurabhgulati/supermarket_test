class PricingRules
  def initialize
    @special_prices = {}
  end

  def add_special_price(sku, quantity, price)
    @special_prices[sku] = { quantity: quantity, price: price }
  end

  def calculate_price(sku, quantity, unit_price)
    return quantity * unit_price unless @special_prices[sku]

    special = @special_prices[sku]
    special_count = quantity / special[:quantity]
    normal_count = quantity % special[:quantity]
    special_count * special[:price] + normal_count * unit_price
  end
end
