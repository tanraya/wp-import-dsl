module WpImportDsl
  class Tag
    def initialize(tag)
      @tag = tag
    end

    def method_missing(method, *args, &block)
      @tag.send(method) if @tag.respond_to? method
    end
  end
end