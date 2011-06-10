module WpImportDsl
  module Wxr
    # Blog data
    class Blog < Base
      attr_accessor :categories, :tags

      attrs :scope => '//channel/wp:' do
        wxr_version
        base_site_url :alias => :site_url
        base_blog_url :alias => :blog_url
      end


      def initialize(doc = nil)
        super doc
        self.categories ||= Wxr::Reader.grab_categories(doc)
        #self.tags       ||= []
        puts Wxr::Reader.grab_categories(doc.find)
      end


=begin

      attr_accessor :wxr_version, :base_site_url, :base_blog_url,
                      :categories, :tags

      def read!
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

        self.wxr_version   = retrieve "//channel/wp:wxr_version"
        self.base_site_url = retrieve "//channel/wp:base_site_url"
        self.base_blog_url = retrieve "//channel/wp:base_blog_url"
        self.categories    = blog_categories
        self.tags          = blog_tags
      end
=end
    end
  end
end