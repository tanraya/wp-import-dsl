module WpImportDsl
  require File.dirname(__FILE__) + '/categories'
  require File.dirname(__FILE__) + '/tags'

  module Blog
    module ClassMethods
      extend WpImportDsl::Categories::ClassMethods
      extend WpImportDsl::Tags::ClassMethods

      def blog(&block)
        if block_given?
          attributes = Attributes.new
          attributes.instance_eval(&block)
        end
        
        puts 'blog'
      end
    end

    class Attributes

      def method_missing(method, *args, &block)
        puts method
      end
    end
  end
end