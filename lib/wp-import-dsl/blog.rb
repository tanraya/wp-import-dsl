module WpImportDsl
  class Blog < Base
    def initialize(blog, options)
      @blog    = blog
      @options = options
    end

    def tags(options, &block)
      exec(Tag, :tags, options, &block)
    end

    def categories(options, &block)
      exec(Category, :categories, options, &block)
    end

    def method_missing(method, *args, &block)
      @blog.send(method) if @blog.respond_to? method
    end
  end
end