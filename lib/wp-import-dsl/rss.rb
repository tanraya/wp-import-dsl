module WpImportDsl
  class Rss < Base
    def initialize(rss, options)
      @rss     = rss
      @options = options
    end

    def method_missing(method, *args, &block)
      @rss.send(method) if @rss.respond_to? method
    end
  end
end