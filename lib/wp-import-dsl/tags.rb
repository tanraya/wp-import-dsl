module WpImportDsl
  module Tags
    module ClassMethods
      def tags(&block)
        class_eval(&block) if block_given?
        puts 'tags'
      end
    end
  end
end