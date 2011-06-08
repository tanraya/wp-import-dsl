module WpImportDsl
  module Wxr
    class Base
      def initialize(doc = nil)
        @doc = doc
      end

      def retrieve(key)
        @doc.xpath(key).text
      end
    end
  end
end