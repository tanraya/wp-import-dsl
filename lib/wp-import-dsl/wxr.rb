require 'nokogiri'

module WpImportDsl
  # Parse XML data and keep parsed data
  module Wxr
    autoload :Base,     'wp-import-dsl/wxr/base'
    autoload :Rss,      'wp-import-dsl/wxr/rss'
    autoload :Blog,     'wp-import-dsl/wxr/blog'
    autoload :Tag,      'wp-import-dsl/wxr/tag'
    autoload :Image,    'wp-import-dsl/wxr/image'
    autoload :Postmeta, 'wp-import-dsl/wxr/postmeta'
    autoload :Comment,  'wp-import-dsl/wxr/comment'
    autoload :Category, 'wp-import-dsl/wxr/category'
    autoload :Item,     'wp-import-dsl/wxr/item'

    # Read structured data from WXR source
    class Reader
      attr_accessor :doc

      def initialize(source)
        @doc = Nokogiri::XML(File.open(source), nil, 'utf-8')
      end

      def rss
        Rss.new(@doc)#.read!
      end

      def blog
        Blog.new(@doc)#.read!
      end

      def items
        grab_items(@doc)
      end

    private

      def grab_items(doc)
        items = []

        doc.xpath("//channel/item").each do |item_doc|
          item = Item.new(item_doc)
          item.read!
          item.postmetas  = grab_postmetas(item_doc)
          item.categories = grab_categories(item_doc)
          item.tags       = grab_tags(item_doc)
          item.images     = grab_images(item_doc)
          item.comments   = grab_comments(item_doc)

          items << item
        end

        items
      end

      def grab_postmetas(doc)
        postmetas = []
        doc.xpath("wp:postmeta") do |x|
          postmetas << Postmeta.new(x)#.read!
        end

        postmetas
      end

      def grab_categories(doc)
        categories = []
        doc.xpath("wp:category").each do |x|
          categories << Category.new(x)#.read!
        end

        categories
      end

      def grab_tags(doc)
        tags = []
        doc.xpath("wp:tag").each do |x|
          tags << Tag.new(x)#.read!
        end

        tags
      end

      def grab_images(doc)
        images = []
        doc.xpath("wp:attachment_url").each do |x|
          images << Image.new(x)#.read!
        end

        images
      end

      def grab_comments(doc)
        comments = []
        doc.xpath("wp:comment").each do |x|
          comments << Comment.new(x)#.read!
        end

        comments
      end

    end
  end
end
