module WpImportDsl
  class Blog
    def initialize(blog)
      @blog = blog
    end

    def tags(&block)
      return unless @blog.respond_to? :tags

      @blog.tags.each do |tag|
        t = Tag.new(tag)
        t.instance_eval(&block)
      end
    end

    def categories(&block)
      return unless @blog.respond_to? :categories

      @blog.categories.each do |category|
        c = Category.new(category)
        c.instance_eval(&block)
      end
    end

    def method_missing(method, *args, &block)
      @blog.send(method) if @blog.respond_to? method
    end
  end
end