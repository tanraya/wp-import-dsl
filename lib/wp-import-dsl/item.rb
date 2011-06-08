module WpImportDsl
  class Item < Base
    def comments(options, &block)
      exec_each(Comment, :comments, options, &block)
    end
  end
end