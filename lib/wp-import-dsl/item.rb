module WpImportDsl
  class Item < Base
    def initialize(item, options)
      @item    = item
      @options = options
    end

    def comments(options, &block)
      exec(Comment, :comments, options, &block)
    end

    def tags(options, &block)
      exec(Tag, :tags, options, &block)
    end

    def categories(options, &block)
      exec(Category, :categories, options, &block)
    end

    def method_missing(method, *args, &block)
      @item.send(method) if @item.respond_to? method
    end
  end
end