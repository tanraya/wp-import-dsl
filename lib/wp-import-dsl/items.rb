module WpImportDsl
  # Всем им должен быть доступен текущий итем
  autoload :Comments,   'wp-import-dsl/comments'

  module Items
    module ClassMethods
      def items(&block)
        return unless block_given?
        
        WpImportDsl.reader.items.each do |item|
          proxy = Proxy.new(item)
          proxy.instance_eval(&block)
        end
      end
    end

    class Proxy
      #include Comments::ClassMethods

      def initialize(item)
        @@item = item
      end

      def self.item
        @@item
      end

      def method_missing(method, *args, &block)
        if @@item.respond_to?(method)
          return @@item.send(method)
        end
      end
    end
  end
end