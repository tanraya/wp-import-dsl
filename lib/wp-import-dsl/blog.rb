module WpImportDsl
  autoload :Tags,       'wp-import-dsl/tags'
  autoload :Categories, 'wp-import-dsl/categories'

  module Blog
    module ClassMethods
      extend WpImportDsl::Categories::ClassMethods
      extend WpImportDsl::Tags::ClassMethods

      def blog(&block)
        Attributes.new.instance_eval(&block) if block_given?
      end
    end

    class Attributes
      def method_missing(method, *args, &block)
        if WpImportDsl.reader.blog.respond_to?(method)
          return WpImportDsl.reader.blog.send(method)
        end

        nil
      end
    end
  end
end