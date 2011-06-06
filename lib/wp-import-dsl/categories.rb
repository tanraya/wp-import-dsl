module WpImportDsl
  module Categories
    module ClassMethods
      def categories(&block)
        class_eval(&block) if block_given?
        puts 'categories'
      end
    end
  end
end