module WpImportDsl
  module Wxr
    # Tag data
    class Tag < Base
      attr_accessor :tag_slug, :tag_name

      def read!
        self.tag_name   = @doc.xpath("wp:tag_slug").text
        self.tag_slug   = @doc.xpath("wp:tag_name").text
      end
    end
  end
end