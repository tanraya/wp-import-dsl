module WpImportDsl
  class Postmeta < Base
    def initialize(postmeta, options)
      @postmeta = postmeta
      @options  = options
    end

    def method_missing(method, *args, &block)
      @postmeta.send(method) if @postmeta.respond_to? method
    end
  end
end