module WpImportDsl
  module Rss
    module ClassMethods
      def rss(&block)
        Attributes.new.instance_eval(&block) if block_given?
      end
    end

    class Attributes
      def method_missing(method, *args, &block)
        if WpImportDsl.reader.rss.respond_to?(method)
          return WpImportDsl.reader.rss.send(method)
        end

        nil
      end
    end
  end
end