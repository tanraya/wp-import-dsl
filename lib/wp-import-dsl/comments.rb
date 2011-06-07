module WpImportDsl
  module Comments
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

    class Proxy
      def method_missing(method, *args, &block)
        puts method
      end
    end
  end
end