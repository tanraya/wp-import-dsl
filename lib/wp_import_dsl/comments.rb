module WpImportDsl
  module Comments
    module ClassMethods
      def comments(options, &block)
        class_eval(&block) if block_given?
        puts 'comments'
      end
    end
  end
end