require 'test/unit'
require 'rubygems'
require 'active_record'
require 'sqlite3'
require File.dirname(File.expand_path(__FILE__)) + "/../lib/acts_as_money"


class MoneyTest < Test::Unit::TestCase
  
  class Product < ActiveRecord::Base
    acts_as_money
    money :price
  end

  class Donation < ActiveRecord::Base
    acts_as_money
    money :amount, :allow_nil => true
  end

  class Service < ActiveRecord::Base
    acts_as_money
    money :price, :cents => :service_cents, :currency => :service_currency 
  end

  def setup
    ActiveRecord::Base.establish_connection(
      :adapter  => "sqlite3",
      :database => ":memory:"
    )

    ActiveRecord::Schema.define do
      create_table :products do |t|
        t.integer :cents
        t.string  :currency
      end

      create_table :services do |t|
        t.integer :service_cents
        t.string  :service_currency
      end

      create_table :donations do |t|
        t.integer :cents
        t.string  :currency
      end
    end
  
  end

  def teardown
    ActiveRecord::Base.remove_connection
  end

  def test_it_serializes_amount
    product = Product.create(:price => Money.new(100, "GBP"))
    product = Product.find(product.id)
    assert_equal(product.cents, product.price.cents)
  end

  def test_it_serializes_currency
    product = Product.create(:price => Money.new(100, "GBP"))
    product = Product.find(product.id)
    assert_equal(product.currency, product.price.currency.iso_code)
  end

  def test_it_unserializes_money_object
    product = Product.create(:cents =>200, :currency => "USD")
    product = Product.find(product.id)
    assert_equal(product.currency, product.price.currency.iso_code)
    assert_equal(product.cents, product.price.cents)
  end

  def test_default_value
    product = Product.new
    assert_equal(product.price.cents, 0)
    assert_equal(product.price.currency, Money.default_currency)
  end

  def test_allow_nil
    donation = Donation.new
    assert_nil(donation.amount)
  end

  def test_instantiation_with_integer
    product = Product.create(:price => 100)
    assert_equal(product.price.cents, 10000)
    assert_equal(product.price.currency, Money.default_currency)
  end
 
  def test_instantiation_with_zero
    product = Product.create(:price => 0)
    assert_equal(product.price.cents, 0)
    assert_equal(product.price.currency, Money.default_currency)
  end

  def test_instantiation_with_float
    product = Product.create(:price => 100.50)
    assert_equal(product.price.cents, 10050)
    assert_equal(product.price.currency, Money.default_currency)
  end

  def test_instantiation_with_roundable_float
    product = Product.create(:price => 32.66)
    assert_equal(product.price.cents, 3266)
    assert_equal(product.price.currency, Money.default_currency)
  end

  def test_instantiation_with_string
    product = Product.create(:price => "100.50")
    assert_equal(product.price.cents, 10050)
    assert_equal(product.price.currency, Money.default_currency)
  end

  def test_it_serializes_amount_with_named_columns
    service = Service.create(:price => Money.new(100, "GBP"))
    service = Service.find(service.id)
    assert_equal(service.service_cents, service.price.cents)
  end

  def test_it_serializes_currency_with_named_columns
    service = Service.create(:price => Money.new(100, "GBP"))
    service = Service.find(service.id)
    assert_equal(service.service_currency, service.price.currency.iso_code)
  end

  def test_it_unserializes_money_object_with_named_columns
    service = Service.create(:service_cents =>200, :service_currency => "USD")
    service = Service.find(service.id)
    assert_equal(service.service_currency, service.price.currency.iso_code)
    assert_equal(service.service_cents, service.price.cents)
  end

end
