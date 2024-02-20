require './item.rb'
class Checkout
  def initialize(pricing_rules)
    @items = Item.load_csv_data
    @pricing_rules = pricing_rules
    @added_items = Hash.new(0)
  end

  def scan(item)
    @added_items[item.sku] += 1
  end

  def total
    @added_items.sum do |sku, quantity|
      unit_price = @items.select{|i| i.sku == sku}[0]&.price.to_f
      @pricing_rules.calculate_price(sku, quantity, unit_price)
    end
  end
end
