module WpImportDsl
  class Tag < Base
    def initialize(tag, options)
      @tag     = tag
      @options = options
    end

    def method_missing(method, *args, &block)
      @tag.send(method) if @tag.respond_to? method
    end
  end
end