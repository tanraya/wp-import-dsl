module WpImportDsl
  module Wxr
    # Item (post or page)
    class Item < Base
      STATUSES      = ['publish', 'draft', 'pending', 'private']
      POST_TYPES    = ['post', 'page', 'media']
      PING_STATUSES = []

      attr_accessor :title, :link, :pubDate, :creator, :guid, :description, :content,
                    :excerpt, :post_id, :post_date, :post_date_gmt, :comment_status,
                    :ping_status, :post_name, :status, :post_parent, :menu_order,
                    :post_type, :post_password, :attachment_url, :is_sticky, :postmetas,
                    :categories, :tags, :images, :comments

      def read!
        @categories ||= []
        @postmeta   ||= []
        @tags       ||= []
        @images     ||= []
        @comments   ||= []

        self.title          = @doc.xpath("title").text
        self.link           = @doc.xpath("link").text
        self.pubDate        = @doc.xpath("pubDate").text
        self.creator        = @doc.xpath("dc:creator").text
        self.guid           = @doc.xpath("guid").text
        self.description    = @doc.xpath("description").text
        self.content        = @doc.xpath("content").text
        self.excerpt        = @doc.xpath("excerpt").text
        self.post_id        = @doc.xpath("wp:post_id").text
        self.post_date      = @doc.xpath("wp:post_date").text
        self.post_date_gmt  = @doc.xpath("wp:post_date_gmt").text
        self.comment_status = @doc.xpath("wp:comment_status").text
        self.ping_status    = @doc.xpath("wp:ping_status").text
        self.post_name      = @doc.xpath("wp:post_name").text
        self.status         = @doc.xpath("wp:status").text
        self.post_parent    = @doc.xpath("wp:post_parent").text
        self.menu_order     = @doc.xpath("wp:menu_order").text
        self.post_type      = @doc.xpath("wp:post_type").text
        self.post_password  = @doc.xpath("wp:post_password").text
        self.attachment_url = @doc.xpath("wp:attachment_url").text
        self.is_sticky      = @doc.xpath("wp:is_sticky").text
        self.postmetas      = postmetas
        self.categories     = categories
        self.tags           = tags
        self.images         = images
        self.comments       = comments
        self
      end

      # Is this item a blog post?
      def post?
        self.post_type == 'post'
      end

      # Is this item a page?
      def page?
        self.post_type == 'page'
      end

      # Is this item a media?
      def media?
        self.post_type == 'media'
      end

      def publish?
        self.status == 'publish'
      end

      def draft?
        self.status == 'draft'
      end

      def pending?
        self.status == 'pending'
      end

      def private?
        self.status == 'private'
      end

      def sticky?
        self.is_sticky.to_i > 0
      end
    end
  end
end