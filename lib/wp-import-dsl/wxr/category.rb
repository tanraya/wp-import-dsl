module WpImportDsl
  module Wxr
    # Category data
    class Category < Base
      attrs :scope => 'wp:' do
        cat_name          :alias => :name
        category_parent   :alias => :parent
        category_nicename :alias => :nicename
      end
=begin
      attr_accessor :cat_name, :category_parent, :category_nicename

      def read!
        self.cat_name          = retrieve "wp:cat_name"
        self.category_parent   = retrieve "wp:category_parent"
        self.category_nicename = retrieve "wp:category_nicename"
      end
=end
    end
  end
end