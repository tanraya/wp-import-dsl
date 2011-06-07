require 'open-uri'

module WpImportDsl
  module Wxr
    class Rss < Base
      attr_accessor :title, :description, :link, :pubDate,
                      :generator, :language, :cloud, :image

      def read!
        @title       = @doc.xpath("//channel/title").text
        @description = @doc.xpath("//channel/description").text
        @link        = @doc.xpath("//channel/link").text
        @pubDate     = @doc.xpath("//channel/pubDate").text
        @generator   = @doc.xpath("//channel/generator").text
        @language    = @doc.xpath("//channel/language").text
        @cloud       = @doc.xpath("//channel/cloud").text
        @image       = @doc.xpath("//channel/image").text
        self
      end

      def image=(image_url)
        @image = nil#File.new # mock
      end

      def pubDate=(str)
        @pubDate = DateTime.parse(str)
      end

      alias :pub_date :pubDate
    end
  end
end