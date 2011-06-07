module WpImportDsl
  module Wxr
    # Blog data
    class Blog < Base
      attr_accessor :wxr_version, :base_site_url, :base_blog_url,
                    :categories, :tags

      def read!
=begin
        blog_categories = []
        @doc.xpath("//channel/wp:category").each do |c|
          category = Category.new
          category.cat_name          = c.xpath("wp:cat_name").text
          category.category_parent   = c.xpath("wp:category_parent").text
          category.category_nicename = c.xpath("wp:category_nicename").text
          blog_categories << category
        end

        blog_tags = []
        @doc.xpath("//channel/wp:tag").each do |c|
          tag = Tag.new
          tag.tag_name   = c.xpath("wp:tag_slug").text
          tag.tag_slug   = c.xpath("wp:tag_name").text
          blog_tags << tag
        end
=end

        self.wxr_version   = @doc.xpath("//channel/wp:wxr_version").text
        self.base_site_url = @doc.xpath("//channel/wp:base_site_url").text
        self.base_blog_url = @doc.xpath("//channel/wp:base_blog_url").text
        self.categories    = nil#blog_categories
        self.tags          = nil#blog_tags
      end
    end
  end
end