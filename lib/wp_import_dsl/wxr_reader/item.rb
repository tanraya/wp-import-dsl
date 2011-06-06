module WpImportDsl
  module WxrReader
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
  end
end