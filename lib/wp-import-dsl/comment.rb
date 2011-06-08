module WpImportDsl
  class Comment
    def initialize(comment, options)
      @comment = comment
      @options = options
    end

    def method_missing(method, *args, &block)
      @comment.send(method)
    end
  end
end