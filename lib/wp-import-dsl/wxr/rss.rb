require 'open-uri'

module WpImportDsl
  module Wxr
    class Rss < Base
      attrs :scope => '//channel/' do
        title
        description
        link
        pubDate :alias => :pub_date
        generator
        language
        cloud
        image
      end

      def image=(image_url)
        self.image = nil#File.new # mock
      end

      def pubDate=(str)
        self.pubDate = DateTime.parse(str)
      end
    end
  end
end