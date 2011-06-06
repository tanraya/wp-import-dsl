module WpImportDsl
  module WxrReader
    # Item's postmeta data
    class Postmeta
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
    end
  end
end