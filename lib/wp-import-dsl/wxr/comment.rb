module WpImportDsl
  module Wxr
    # Item's comment
    class Comment < Base
      attr_accessor :comment_id, :comment_author, :comment_author_email, :comment_author_url,
                    :comment_author_IP, :comment_date, :comment_date_gmt, :comment_content,
                    :comment_approved, :comment_type, :comment_parent, :comment_user_id

      def read!
        self.comment_id           = @doc.xpath("wp:comment_id").text
        self.comment_author       = @doc.xpath("wp:comment_author").text
        self.comment_author_email = @doc.xpath("wp:comment_author_email").text
        self.comment_author_url   = @doc.xpath("wp:comment_author_url").text
        self.comment_author_IP    = @doc.xpath("wp:comment_author_IP").text
        self.comment_date         = @doc.xpath("wp:comment_date").text
        self.comment_date_gmt     = @doc.xpath("wp:comment_date_gmt").text
        self.comment_content      = @doc.xpath("wp:comment_content").text
        self.comment_approved     = @doc.xpath("wp:comment_approved").text
        self.comment_type         = @doc.xpath("wp:comment_type").text
        self.comment_parent       = @doc.xpath("wp:comment_parent").text
        self.comment_user_id      = @doc.xpath("wp:comment_user_id").text
        self
      end

      # Neet to check it out
      def spam?
        self.comment_type == 'spam'
      end

      alias :id           :comment_id
      alias :author       :comment_author
      alias :author_email :comment_author_email
      alias :author_url   :comment_author_url
      alias :author_ip    :comment_author_IP
      alias :date         :comment_date
      alias :date_gmt     :comment_date_gmt
      alias :content      :comment_content
      alias :approved     :comment_approved
      alias :type         :comment_type
      alias :parent       :comment_parent
      alias :user_id      :comment_user_id
    end
  end
end