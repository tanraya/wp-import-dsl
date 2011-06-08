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

    # Тут должен делаться инстанс евал для блоков
    class Proxy
      #include Comments::ClassMethods

      def initialize(item)
        @item = item
      end

      def method_missing(method, *args, &block)
        if method == :comments
          puts @item.comments.shift.methods
          @item.comments.each do |comment|
            #puts comment
            proxy = Comments::Proxy.new(comment)
            proxy.instance_eval(&block)
          end
        elsif @item.respond_to?(method)
          return @item.send(method)
        end
      end
    end
  end
end