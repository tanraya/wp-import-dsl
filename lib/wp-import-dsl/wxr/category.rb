module WpImportDsl
  module Wxr
    # Category data
    class Category < Base
      attr_accessor :cat_name, :category_parent, :category_nicename

      def read!
        self.cat_name          = @doc.xpath("wp:cat_name").text
        self.category_parent   = @doc.xpath("wp:category_parent").text
        self.category_nicename = @doc.xpath("wp:category_nicename").text
      end
    end
  end
end