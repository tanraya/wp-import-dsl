require 'nokogiri'

module WpImportDsl
  # Parse XML data and keep parsed data
  module WxrReader
    require File.dirname(__FILE__) + '/wxr-reader/rss'
    require File.dirname(__FILE__) + '/wxr-reader/blog'
    require File.dirname(__FILE__) + '/wxr-reader/tags'
    require File.dirname(__FILE__) + '/wxr-reader/image'
    require File.dirname(__FILE__) + '/wxr-reader/postmeta'
    require File.dirname(__FILE__) + '/wxr-reader/comment'
    require File.dirname(__FILE__) + '/wxr-reader/category'
    require File.dirname(__FILE__) + '/wxr-reader/item'
    
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

        i = Item.new
        i.title          = item.xpath("title").text
        i.link           = item.xpath("link").text
        i.pub_date       = item.xpath("pubDate").text
        i.creator        = item.xpath("dc:creator").text
        i.guid           = item.xpath("guid").text
        i.description    = item.xpath("description").text
        i.content        = item.xpath("content").text
        i.excerpt        = item.xpath("excerpt").text
        i.post_id        = item.xpath("wp:post_id").text
        i.post_date      = item.xpath("wp:post_date").text
        i.post_date_gmt  = item.xpath("wp:post_date_gmt").text
        i.comment_status = item.xpath("wp:comment_status").text
        i.ping_status    = item.xpath("wp:ping_status").text
        i.post_name      = item.xpath("wp:post_name").text
        i.status         = item.xpath("wp:status").text
        i.post_parent    = item.xpath("wp:post_parent").text
        i.menu_order     = item.xpath("wp:menu_order").text
        i.post_type      = item.xpath("wp:post_type").text
        i.post_password  = item.xpath("wp:post_password").text
        i.attachment_url = item.xpath("wp:attachment_url").text
        i.is_sticky      = item.xpath("wp:is_sticky").text
        i.postmetas      = postmetas
        i.categories     = categories
        i.tags           = tags
        i.images         = images
        i.comments       = comments

        @items << i
      end

      return @rss, @blog, @items
    end
  end
end

source = File.dirname(__FILE__) + '/../../test/wordpress.2011-06-03.xml'
rss, blog, items = WpImportDsl::WxrReader.read!(source)
puts items.first.title

