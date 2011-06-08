module WpImportDsl
  class Item
    def initialize(item, options = nil)
      @item    = item
      @options = options
    end

    def comments(options, &block)
      return unless @item.respond_to? :tags

      @item.comments.each do |comment|
        c = Comment.new(comment, options)
        c.instance_eval(&block)
      end
    end

    def tags(&block)
      return unless @item.respond_to? :tags

      @item.tags.each do |tag|
        t = Tag.new(tag)
        t.instance_eval(&block)
      end
    end

    def categories(&block)
      return unless @item.respond_to? :categories

      @item.categories.each do |category|
        c = Category.new(category)
        c.instance_eval(&block)
      end
    end

    def method_missing(method, *args, &block)
      @item.send(method) if @item.respond_to? method
    end
  end
end