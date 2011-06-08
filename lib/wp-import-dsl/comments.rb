module WpImportDsl
  module Comments
=begin
    module ClassMethods
      # Its does not calls!
      def comments(options, &block)
        return unless block_given?
        puts 'yay'
        comments = [] # Где взять?????
        comments.each do |comment|
          proxy = Proxy.new(comment)
          proxy.instance_eval(&block)
        end
      end
    end
=end

    class Proxy
      def initialize(comment)
        @comment = comment
      end

      def method_missing(method, *args, &block)
        if @comment.respond_to?(method)
          return @comment.send(method)
        end
      end
    end
  end
end