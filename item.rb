require 'csv'

class Item
  attr_reader :sku, :price

  def initialize(sku, price)
    @sku = sku
    @price = price
  end

  def self.get_price(sku)
    return items.select{|i| i.sku == sku}[0]&.price
  end

  class << self
    attr_reader :items

    def load_csv_data
      @items = []
      CSV.parse(File.read("./item_db.csv"), headers: true).each do |row| 
        @items << Item.new(row['Sku'], row['Price'])
      end

      return @items
    end

    def find_by_sku sku
      @items.select{|x| x.sku == sku}[0]
    end
  end
end
