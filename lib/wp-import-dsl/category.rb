module WpImportDsl
  class Category
    def initialize(category)
      @category = category
    end

    def method_missing(method, *args, &block)
      @category.send(method) if @category.respond_to? method
    end
  end
end