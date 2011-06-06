module WpImportDsl
  require File.dirname(__FILE__) + '/categories'
  require File.dirname(__FILE__) + '/tags'
  require File.dirname(__FILE__) + '/images'
  require File.dirname(__FILE__) + '/postmeta'
  require File.dirname(__FILE__) + '/comments'

  module Items
    module ClassMethods
      extend WpImportDsl::Categories::ClassMethods
      extend WpImportDsl::Tags::ClassMethods
      extend WpImportDsl::Images::ClassMethods
      extend WpImportDsl::Postmeta::ClassMethods
      extend WpImportDsl::Comments::ClassMethods

      def items(&block)
        if block_given?
          attributes = Attributes.new
          attributes.instance_eval(&block)
        end
        
        puts 'items'
      end
    end

    class Attributes
      def title
        puts ':title'
      end

      def description
        puts ':description'
      end


      def method_missing(method, *args, &block)
        puts method
      end
    end
  end
end