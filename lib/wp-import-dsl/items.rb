module WpImportDsl
  # Всем им должен быть доступен текущий итем
  autoload :Categories, 'wp-import-dsl/categories'
  autoload :Tags,       'wp-import-dsl/tags'
  autoload :Images,     'wp-import-dsl/images'
  autoload :Postmeta,   'wp-import-dsl/postmeta'
  autoload :Comments,   'wp-import-dsl/comments'

  module Items
    module ClassMethods
      extend Categories::ClassMethods
      extend Tags::ClassMethods
      extend Images::ClassMethods
      extend Postmeta::ClassMethods
      extend Comments::ClassMethods

      def items(&block)
        return unless block_given?
        
        WpImportDsl.reader.items.each do |item|
          attributes = Attributes.new(item)
          attributes.instance_eval(&block)
        end
      end

      def comments(options, &block)
        # Как добраться к текущему item
      end
    end

    class Attributes
      def initialize(item)
        @@item = item
      end

      def item
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