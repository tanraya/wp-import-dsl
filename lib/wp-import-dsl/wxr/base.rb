module WpImportDsl
  module Wxr
    class Base
      def initialize(doc = nil)
        @doc = doc
      end

      def retrieve(key)
        @doc.xpath(key).text
      end

      def self.attrs(options = {}, &block)
        @attrs_options ||= {}
        @attrs_options[:scope] = options[:scope]
        instance_eval(&block)
      end

      def self.method_missing(method, *args, &block)
        # TODO Cleanup options
        options = args.shift || {}
        options[:scope] = options[:scope] || @attrs_options[:scope]

        class_eval %Q{
          def #{method}
            retrieve("#{options[:scope]}#{method}")
          end
        }

        unless options[:alias].nil?
          class_eval "alias #{options[:alias]} #{method}"
        end
      end
    end
  end
end