module WpImportDsl
  module Rss
    module ClassMethods
      def rss(&block)
        class_eval(&block) if block_given?
        puts 'rss'
      end
    end
  end
end