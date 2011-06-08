module WpImportDsl
  module Wxr
    # Image
    class Image < Base
      attr_accessor :width, :height, :aperture, :credit, :camera, :caption,
                    :created_timestamp, :copyright, :focal_length, :iso,
                    :shutter_speed, :title, :image

      def read!
        self.image             = nil # fetch image from attachment_url
        self.width             = nil
        self.height            = nil
        self.aperture          = nil
        self.credit            = nil
        self.camera            = nil
        self.caption           = nil
        self.created_timestamp = nil
        self.copyright         = nil
        self.focal_length      = nil
        self.iso               = nil
        self.shutter_speed     = nil
        self.title             = nil
        self
      end
    end
  end
end