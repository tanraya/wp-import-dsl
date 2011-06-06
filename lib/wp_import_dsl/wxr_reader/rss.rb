module WpImportDsl
  module WxrReader
    class Rss
      attr_accessor :title, :description, :link, :pubDate,
                      :generator, :language, :cloud

      attr_reader   :image

      def image=(image_url)
        @image = nil#File.new # mock
      end
    end
  end
end