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
      composed_of name,  {
        :class_name => 'Money',
        :allow_nil => options[:allow_nil],
        :mapping => [
          [(options[:cents] || :cents).to_s, 'cents'],
          [(options[:currency] || :currency).to_s, 'currency_as_string']
        ],
        :constructor => lambda {|cents, currency| Money.new(cents || 0, currency || Money.default_currency)}
      }      
    end
  end
end



