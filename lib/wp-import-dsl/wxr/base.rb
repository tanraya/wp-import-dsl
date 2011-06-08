module WpImportDsl
  module Wxr
    class Base
      attr_accessor :doc

      def initialize(doc = nil)
        @doc = doc
      end
    end
  end
end