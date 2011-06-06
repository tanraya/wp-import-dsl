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
        class_eval(&block) if block_given?
        puts 'items'
      end
    end
  end
end