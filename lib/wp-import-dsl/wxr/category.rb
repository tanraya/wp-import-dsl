module WpImportDsl
  module Wxr
    # Category data
    class Category < Base
      attr_accessor :cat_name, :category_parent, :category_nicename

      def read!
        self.cat_name          = retrieve "wp:cat_name"
        self.category_parent   = retrieve "wp:category_parent"
        self.category_nicename = retrieve "wp:category_nicename"
      end
    end
  end
end