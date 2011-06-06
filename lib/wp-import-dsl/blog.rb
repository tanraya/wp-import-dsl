module WpImportDsl
  module Blog
    module ClassMethods
      extend WpImportDsl::Categories::ClassMethods
      extend WpImportDsl::Tags::ClassMethods

      def blog(&block)
        class_eval(&block) if block_given?
        puts 'blog'
      end
    end
  end
end