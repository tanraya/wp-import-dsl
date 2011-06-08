module WpImportDsl
  class Category < Base
    def initialize(category, options)
      @category = category
      @options  = options
    end

    def method_missing(method, *args, &block)
      @category.send(method) if @category.respond_to? method
    end
  end
end