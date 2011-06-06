module WpImportDsl
  module WxrReader
    # Blog data
    class Blog
      attr_accessor :wxr_version, :base_site_url, :base_blog_url,
                    :categories, :tags
    end
  end
end