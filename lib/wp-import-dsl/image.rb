module WpImportDsl
  class Image
    def initialize(image)
      @image = image
    end

    def method_missing(method, *args, &block)
      @image.send(method) if @image.respond_to? method
    end
  end
end