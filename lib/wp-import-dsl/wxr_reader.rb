require 'nokogiri'

module WpImportDsl

  # Parse XML data and keep parsed data
  module WxrReader
    # RSS feed data
    class Rss
      attr_accessor :title, :description, :link, :pubDate,
                    :generator, :language, :cloud

      attr_reader   :image

      def image=(image_url)
        @image = nil#File.new # mock
      end
    end

    # Blog data
    class Blog
      attr_accessor :wxr_version, :base_site_url, :base_blog_url,
                    :categories, :tags
    end

    # Category data
    class Category
      attr_accessor :cat_name, :category_parent, :category_nicename
    end

    # Tag data
    class Tag
      attr_accessor :tag_slug, :tag_name
    end

    # Image
    class Image
      attr_accessor :width, :height, :aperture, :credit, :camera, :caption,
                    :created_timestamp, :copyright, :focal_length, :iso,
                    :shutter_speed, :title
    end

    # Item's postmeta data
    class Postmeta
      POSSIBLE_KEYS = [
        'delicious',
        'geo_latitude',
        'geo_longitude',
        'geo_accuracy',
        'geo_address',
        'geo_public',
        'email_notification',
        '_wpas_done_yup',
        '_wpas_done_twitter',
        'reddit',
        '_edit_last',
        '_edit_lock'
      ]

      attr_accessor :meta_key, :meta_value
    end

    # Item's comment
    class Comment
      attr_accessor :comment_id, :comment_author, :comment_author_email, :comment_author_url,
                    :comment_author_ip, :comment_date, :comment_date_gmt, :comment_content,
                    :comment_approved, :comment_type, :comment_parent, :comment_user_id
      
      def spam?
        true
      end
    end

    # Item (post or page)
    class Item
      STATUSES      = ['publish', 'draft', 'pending', 'private']
      POST_TYPES    = ['post', 'page', 'media']
      PING_STATUSES = []

      attr_accessor :title, :link, :pub_date, :creator, :guid, :description, :content,
                    :excerpt, :post_id, :post_date, :post_date_gmt, :comment_status,
                    :ping_status, :post_name, :status, :post_parent, :menu_order,
                    :post_type, :post_password, :attachment_url, :is_sticky, :postmetas,
                    :categories, :tags, :images, :comments

      def initialize
        @categories ||= []
        @postmeta   ||= []
        @tags       ||= []
        @images     ||= []
        @comments   ||= []
      end

      # Is this item a blog post?
      def post?
        true
      end

      # Is this item a page?
      def page?
        true
      end

      # Is this item a media?
      def media?
        true
      end

      def publish?
        true
      end

      def draft?
        true
      end

      def pending?
        true
      end

      def private?
        true
      end

      def sticky?
        true
      end
    end

    attr_accessor :rss, :blog, :items

    def self.read!(source)
      doc = Nokogiri::XML(File.open(source), nil, 'utf-8')

      # TODO: cleanup

      # RSS stuff
      @rss = Rss.new
      @rss.title       = doc.xpath("//channel/title").text
      @rss.description = doc.xpath("//channel/description").text
      @rss.link        = doc.xpath("//channel/link").text
      @rss.pubDate     = doc.xpath("//channel/pubDate").text
      @rss.generator   = doc.xpath("//channel/generator").text
      @rss.language    = doc.xpath("//channel/language").text
      @rss.cloud       = doc.xpath("//channel/cloud").text
      @rss.image       = doc.xpath("//channel/image").text


      # Blog stuff
      blog_categories = []
      doc.xpath("//channel/wp:category").each do |c|
        category = Category.new
        category.cat_name          = c.xpath("wp:cat_name").text
        category.category_parent   = c.xpath("wp:category_parent").text
        category.category_nicename = c.xpath("wp:category_nicename").text
        blog_categories << category
      end

      blog_tags = []
      doc.xpath("//channel/wp:tag").each do |c|
        tag = Tag.new
        tag.tag_name   = c.xpath("wp:tag_slug").text
        tag.tag_slug   = c.xpath("wp:tag_name").text
        blog_tags << tag
      end

      @blog = Blog.new
      @blog.wxr_version   = doc.xpath("//channel/wp:wxr_version").text
      @blog.base_site_url = doc.xpath("//channel/wp:base_site_url").text
      @blog.base_blog_url = doc.xpath("//channel/wp:base_blog_url").text
      @blog.categories    = blog_categories
      @blog.tags          = blog_tags

      # Items!
      @items = []
      doc.xpath("//channel/item").each do |item|
        postmetas = []
        item.xpath("wp:postmeta") do |x|
          postmeta = Postmeta.new
          postmeta.meta_key   = x.xpath("wp:meta_key").text
          postmeta.meta_value = x.xpath("wp:meta_value").text
          postmetas << postmeta
        end

        categories = []
        item.xpath("wp:category").each do |x|
          category = Category.new
          category.cat_name          = x.xpath("wp:cat_name").text
          category.category_parent   = x.xpath("wp:category_parent").text
          category.category_nicename = x.xpath("wp:category_nicename").text
          categories << category
        end

        tags = []
        item.xpath("wp:tag").each do |x|
          tag = Tag.new
          tag.tag_name   = x.xpath("wp:tag_slug").text
          tag.tag_slug   = x.xpath("wp:tag_name").text
          tags << tag
        end

        images = []
        item.xpath("wp:attachment_url").each do |x|
          # TODO: need to fetch all image stuff from postmetas
          image = Image.new
          image.image             = nil # fetch image from attachment_url
          image.width             = nil
          image.height            = nil
          image.aperture          = nil
          image.credit            = nil
          image.camera            = nil
          image.caption           = nil
          image.created_timestamp = nil
          image.copyright         = nil
          image.focal_length      = nil
          image.iso               = nil
          image.shutter_speed     = nil
          image.title             = nil
          images << image
        end

        comments = []
        item.xpath("wp:comment").each do |x|
          comment = Comment.new
          comment.comment_id           = item.xpath("wp:comment_id").text
          comment.comment_author       = item.xpath("wp:comment_author").text
          comment.comment_author_email = item.xpath("wp:comment_author_email").text
          comment.comment_author_url   = item.xpath("wp:comment_author_url").text
          comment.comment_author_ip    = item.xpath("wp:comment_author_ip").text
          comment.comment_date         = item.xpath("wp:comment_date").text
          comment.comment_date_gmt     = item.xpath("wp:comment_date_gmt").text
          comment.comment_content      = item.xpath("wp:comment_content").text
          comment.comment_approved     = item.xpath("wp:comment_approved").text
          comment.comment_type         = item.xpath("wp:comment_type").text
          comment.comment_parent       = item.xpath("wp:comment_parent").text
          comment.comment_user_id      = item.xpath("wp:comment_user_id").text
          comments << comment
        end

        item = Item.new
        item.title          = item.xpath("title").text
        item.link           = item.xpath("link").text
        item.pub_date       = item.xpath("pubDate").text
        item.creator        = item.xpath("dc:creator").text
        item.guid           = item.xpath("guid").text
        item.description    = item.xpath("description").text
        item.content        = item.xpath("content").text
        item.excerpt        = item.xpath("excerpt").text
        item.post_id        = item.xpath("wp:post_id").text
        item.post_date      = item.xpath("wp:post_date").text
        item.post_date_gmt  = item.xpath("wp:post_date_gmt").text
        item.comment_status = item.xpath("wp:comment_status").text
        item.ping_status    = item.xpath("wp:ping_status").text
        item.post_name      = item.xpath("wp:post_name").text
        item.status         = item.xpath("wp:status").text
        item.post_parent    = item.xpath("wp:post_parent").text
        item.menu_order     = item.xpath("wp:menu_order").text
        item.post_type      = item.xpath("wp:post_type").text
        item.post_password  = item.xpath("wp:post_password").text
        item.attachment_url = item.xpath("wp:attachment_url").text
        item.is_sticky      = item.xpath("wp:is_sticky").text
        item.postmetas      = postmetas
        item.categories     = categories
        item.tags           = tags
        item.images         = images
        item.comments       = comments

        @items << item
      end
    end
  end
end

source = File.dirname(__FILE__) + '/../../test/wordpress.2011-06-03.xml'
WpImportDsl::WxrReader.read!(source)

