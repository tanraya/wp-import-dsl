module WpImportDsl
  module Wxr
    # Item's comment
    class Comment < Base
      attrs :scope => 'wp' do
        comment_id           :alias => :id, :scope => nil # We can remove scope
        comment_author       :alias => :author
        comment_author_email :alias => :author_email
        comment_author_url   :alias => :author_url
        comment_author_IP    :alias => :author_ip
        comment_date         :alias => :date
        comment_date_gmt     :alias => :date_gmt
        comment_content      :alias => :content
        comment_approved     :alias => :approved
        comment_type         :alias => :type
        comment_parent       :alias => :parent
        comment_user_id      :alias => :user_id
      end

=begin
      attr_accessor :comment_id, :comment_author, :comment_author_email, :comment_author_url,
                    :comment_author_IP, :comment_date, :comment_date_gmt, :comment_content,
                    :comment_approved, :comment_type, :comment_parent, :comment_user_id

      def read!
        self.comment_id           = retrieve "wp:comment_id"
        self.comment_author       = retrieve "wp:comment_author"
        self.comment_author_email = retrieve "wp:comment_author_email"
        self.comment_author_url   = retrieve "wp:comment_author_url"
        self.comment_author_IP    = retrieve "wp:comment_author_IP"
        self.comment_date         = retrieve "wp:comment_date"
        self.comment_date_gmt     = retrieve "wp:comment_date_gmt"
        self.comment_content      = retrieve "wp:comment_content"
        self.comment_approved     = retrieve "wp:comment_approved"
        self.comment_type         = retrieve "wp:comment_type"
        self.comment_parent       = retrieve "wp:comment_parent"
        self.comment_user_id      = retrieve "wp:comment_user_id"
        self
      end
=end
      # Neet to check it out
      def spam?
        self.comment_type == 'spam'
      end
=begin
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
=end
    end
  end
end