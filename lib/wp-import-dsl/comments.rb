module WpImportDsl
  module Comments
    module ClassMethods
=begin
      def comments(options, &block)
        attributes = Attributes.new
        attributes.instance_eval(&block)

        return unless block_given?

        WpImportDsl.reader.items.each do |item|
          attributes = Attributes.new(item)
          attributes.instance_eval(&block)
        end

      end
=end
    end

    class Attributes
      def method_missing(method, *args, &block)
        puts method
      end
    end
  end
end