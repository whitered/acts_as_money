require 'money'

module CollectiveIdea #:nodoc:
  module Acts
    module Money #:nodoc:
      def self.included(base) #:nodoc:
        base.extend ClassMethods
      end

      module ClassMethods
        def money(name, options = {})
          options = {:cents => :cents, :currency => :currency}.merge(options)
        
          module_eval <<-end_eval
            composed_of :composed_of_#{name}, :class_name => 'Money',
              :mapping => [%w(#{options[:cents]} cents), %w(#{options[:currency] || nil} currency)]
          
            def #{name}=(part)
              self.composed_of_#{name} = part.is_a?(Money) ? part : part.to_money
            end
            def #{name}(force_reload = false)
              self.composed_of_#{name} unless #{options[:cents]}.blank?
            end
          end_eval
        end
      end
    end
  end
end