module WpImportDsl
  module Wxr
    # Item's postmeta data
    class Postmeta < Base
      POSSIBLE_KEYS = [
        'delicious',
        'geo_latitude',
        'geo_longitude',
        'geo_accuracy',
        'geo_address',
        'geo_public',
        'email_notification',
        '_wpas_done_yup',
        '_wpas_done_twitter',
        'reddit',
        '_edit_last',
        '_edit_lock'
      ]

      attr_accessor :meta_key, :meta_value

      def read!
        self.meta_key   = retrieve "wp:meta_key"
        self.meta_value = retrieve "wp:meta_value"
        self
      end
    end
  end
end