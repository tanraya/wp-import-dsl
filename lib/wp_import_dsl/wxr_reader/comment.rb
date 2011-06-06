module WpImportDsl
  module WxrReader
    # Item's comment
    class Comment
      attr_accessor :comment_id, :comment_author, :comment_author_email, :comment_author_url,
                    :comment_author_ip, :comment_date, :comment_date_gmt, :comment_content,
                    :comment_approved, :comment_type, :comment_parent, :comment_user_id

      def spam?
        true
      end
    end
  end
end