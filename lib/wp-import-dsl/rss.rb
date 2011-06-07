module WpImportDsl
  module Rss
    module ClassMethods
      def rss(&block)
        Proxy.new.instance_eval(&block) if block_given?
      end
    end

    class Proxy
      def method_missing(method, *args, &block)
        if WpImportDsl.reader.rss.respond_to?(method)
          WpImportDsl.reader.rss.send(method)
        end
      end
    end
  end
end