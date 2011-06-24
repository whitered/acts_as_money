require 'money'

class ActiveRecord::Base
  class << self
    def acts_as_money
      include(ActsAsMoney)
    end
  end
end


module ActsAsMoney #:nodoc:
  def self.included(base) #:nodoc:
    base.extend ClassMethods
  end

  module ClassMethods

    def money(name, options = {})
      currency_field = (options[:currency] || 'currency').to_s
      cents_field = (options[:cents] || :cents).to_s
      check_nil = options[:allow_nil] ? "#{cents_field}.nil? ? nil : " : ''
      class_eval %{
        def #{name} 
          #{check_nil}Money.new(#{cents_field} || 0, #{currency_field} || Money.default_currency)
        end

        def #{name}= value
          money = if value.is_a?(Money)
            value
          elsif value.respond_to?(:to_money)
            value.to_money(#{currency_field}.nil? || #{currency_field}.empty? ? Money.default_currency : #{currency_field})
          end

          self[:#{cents_field}] = money.try(:cents)
          self[:#{currency_field}] = money.try(:currency_as_string)
        end
      }
    end
  end
end



