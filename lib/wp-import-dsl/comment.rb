module WpImportDsl
  class Comment < Base
    def initialize(comment, options)
      @comment = comment
      @options = options
    end

    def method_missing(method, *args, &block)
      @comment.send(method)
    end
  end
end