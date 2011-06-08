module WpImportDsl
  class Image < Base
    def initialize(image, options)
      @image   = image
      @options = options
    end

    def method_missing(method, *args, &block)
      @image.send(method) if @image.respond_to? method
    end
  end
end