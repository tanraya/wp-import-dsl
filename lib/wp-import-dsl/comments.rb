module WpImportDsl
  module Comments
    module ClassMethods
      def comments(options, &block)
=begin
        return unless block_given?

        WpImportDsl.reader.items.each do |item|
          attributes = Attributes.new(item)
          attributes.instance_eval(&block)
        end
=end
      end
    end
  end
end