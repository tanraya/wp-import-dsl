module WpImportDsl
  module Images
    module ClassMethods
      def images(&block)
        class_eval(&block) if block_given?
        puts 'rss'
      end
    end
  end
end