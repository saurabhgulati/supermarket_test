require 'test/unit'
require_relative 'item'
require_relative 'pricing_rules'
require_relative 'checkout'

class CheckoutTest < Test::Unit::TestCase
  def setup
    #Mock load_csv_data
    def Item.load_csv_data
      @items =[Item.new('A', 50), Item.new('B', 30), Item.new('C', 20)]
      return @items
    end

    @pricing_rules = PricingRules.new
    @checkout = Checkout.new(@pricing_rules)

    # Setup special pricing rules
    @pricing_rules.add_special_price('A', 3, 130)
    @pricing_rules.add_special_price('B', 2, 45)
    
  end

  def test_individual_items
    @checkout.scan(Item.new('C', 20))
    assert_equal(20, @checkout.total)
  end

  def test_special_pricing
    3.times { @checkout.scan(Item.new('A', 50)) }
    assert_equal(130, @checkout.total)
  end

  def test_mixed_items
    @checkout.scan(Item.new('A', 50))
    @checkout.scan(Item.new('B', 30))
    @checkout.scan(Item.new('A', 50))
    @checkout.scan(Item.new('B', 30))
    @checkout.scan(Item.new('C', 20))
    assert_equal(165, @checkout.total)
  end
end
