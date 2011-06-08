module WpImportDsl
  class Rss
    def initialize(rss)
      @rss = rss
    end

    def method_missing(method, *args, &block)
      @rss.send(method) if @rss.respond_to? method
    end
  end
end