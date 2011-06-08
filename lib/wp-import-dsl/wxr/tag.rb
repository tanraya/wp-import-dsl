module WpImportDsl
  module Wxr
    # Tag data
    class Tag < Base
      attrs :scope => 'wp' do
        tag_slug :alias => :slug
        tag_name :alias => :name
      end

=begin
      attr_accessor :tag_slug, :tag_name

      def read!
        self.tag_name   = retrieve "wp:tag_slug"
        self.tag_slug   = retrieve "wp:tag_name"
      end
=end
    end
  end
end