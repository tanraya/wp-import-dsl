module WpImportDsl
  module Postmeta
    module ClassMethods
      def postmeta(&block)
        class_eval(&block) if block_given?
        puts 'postmeta'
      end
    end
  end
end