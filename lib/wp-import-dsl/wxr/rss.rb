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
=begin
      attr_accessor :title, :description, :link, :pubDate,
                      :generator, :language, :cloud, :image

      def read!
        self.title       = retrieve "//channel/title"
        self.description = retrieve "//channel/description"
        self.link        = retrieve "//channel/link"
        self.pubDate     = retrieve "//channel/pubDate"
        self.generator   = retrieve "//channel/generator"
        self.language    = retrieve "//channel/language"
        self.cloud       = retrieve "//channel/cloud"
        self.image       = retrieve "//channel/image"
        self
      end
=end
      def image=(image_url)
        self.image = nil#File.new # mock
      end
=begin
      def pubDate=(str)
        self.pubDate = DateTime.parse(str)
      end

      alias :pub_date :pubDate
=end
    end
  end
end