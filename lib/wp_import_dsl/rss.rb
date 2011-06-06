module WpImportDsl
  module Rss
    module ClassMethods
      def rss(&block)
        if block_given?
          attributes = Attributes.new
          attributes.instance_eval(&block)
        end
      end
    end

    class Attributes
      def title
        puts 'titlez'
      end

      def description
        puts 'descriptionz'
      end

      def generator
        puts 'generatorz'
      end

      def method_missing(method, *args, &block)
        puts method
        nil
      end
    end
  end
end