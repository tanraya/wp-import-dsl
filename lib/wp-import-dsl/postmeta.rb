module WpImportDsl
  class Postmeta
    def initialize(postmeta)
      @postmeta = postmeta
    end

    def method_missing(method, *args, &block)
      @postmeta.send(method) if @postmeta.respond_to? method
    end
  end
end