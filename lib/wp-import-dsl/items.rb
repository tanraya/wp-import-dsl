module WpImportDsl
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