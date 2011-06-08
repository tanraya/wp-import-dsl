module WpImportDsl
  module Wxr
    # Item (post or page)
    class Item < Base
      STATUSES      = ['publish', 'draft', 'pending', 'private']
      POST_TYPES    = ['post', 'page', 'media']
      PING_STATUSES = []

      attr_accessor :postmetas, :categories, :tags, :images, :comments

      attrs :scope => 'wp' do
        title          :scope => nil
        link           :scope => nil
        pubDate        :scope => nil, :alias => :pub_date
        creator        :scope => 'dc'
        guid           :scope => nil
        description    :scope => nil
        content        :scope => nil
        excerpt        :scope => nil
        post_id
        post_date
        post_date_gmt
        comment_status
        ping_status
        post_name
        status
        post_parent
        menu_order
        post_type
        post_password
        attachment_url
        is_sticky
      end

      def initialize
        self.categories ||= []
        self.postmetas  ||= []
        self.tags       ||= []
        self.images     ||= []
        self.comments   ||= []
      end
=begin
      attr_accessor :title, :link, :pubDate, :creator, :guid, :description, :content,
                    :excerpt, :post_id, :post_date, :post_date_gmt, :comment_status,
                    :ping_status, :post_name, :status, :post_parent, :menu_order,
                    :post_type, :post_password, :attachment_url, :is_sticky, :postmetas,
                    :categories, :tags, :images, :comments

      def read!
        categories ||= []
        postmetas  ||= []
        tags       ||= []
        images     ||= []
        comments   ||= []

        self.title          = retrieve "title"
        self.link           = retrieve "link"
        self.pubDate        = retrieve "pubDate"
        self.creator        = retrieve "dc:creator"
        self.guid           = retrieve "guid"
        self.description    = retrieve "description"
        self.content        = retrieve "content"
        self.excerpt        = retrieve "excerpt"
        self.post_id        = retrieve "wp:post_id"
        self.post_date      = retrieve "wp:post_date"
        self.post_date_gmt  = retrieve "wp:post_date_gmt"
        self.comment_status = retrieve "wp:comment_status"
        self.ping_status    = retrieve "wp:ping_status"
        self.post_name      = retrieve "wp:post_name"
        self.status         = retrieve "wp:status"
        self.post_parent    = retrieve "wp:post_parent"
        self.menu_order     = retrieve "wp:menu_order"
        self.post_type      = retrieve "wp:post_type"
        self.post_password  = retrieve "wp:post_password"
        self.attachment_url = retrieve "wp:attachment_url"
        self.is_sticky      = retrieve "wp:is_sticky"
        self.postmetas      = postmetas
        self.categories     = categories
        self.tags           = tags
        self.images         = images
        self.comments       = comments
        self
      end
=end
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