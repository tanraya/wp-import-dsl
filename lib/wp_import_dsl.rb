module WpImportDsl
  #autoload :Rss,   'wp_import_dsl/rss'
  #autoload :Blog,  'wp_import_dsl/blog'
  #autoload :Items, 'wp_import_dsl/items'
  require File.dirname(__FILE__) + '/wp_import_dsl/rss'
  require File.dirname(__FILE__) + '/wp_import_dsl/blog'
  require File.dirname(__FILE__) + '/wp_import_dsl/items'

  extend Rss::ClassMethods
  extend Blog::ClassMethods
  extend Items::ClassMethods

  def self.import(source, &block)
    @@source = source
    instance_eval(&block) if block_given?
  end
end

########################################################################################################################
# DSL example
WpImportDsl.import('filename.xml') do
  rss do
    title         # Contains the site title of the blog.
    description   # Is a tagline that can be modified in the Dashboard under General Settings.
    link          # Is the URL of the blog as determined by WordPress.
    pub_date      # Was the time and date that the WXR document was created. It is in the RFC-822 format http://asg.web.cmu.edu/rfc/rfc822.html
                  # as required by the Rss standard. The format should be self explanatory except for the last numeric value which represents
                  # the local differential from GMT using a +/-hhmm format. Plus 2 hours from GMT would be represented as +0200.
                  # The WordPress time zone can be changed in the Dashboard under General Settings, Timezone.
    generator     # Is the name or a URL pointing to the homepage of the application that was used to create the Rss document.
    language      # Is the primary language the blog is written in as determined by General Setting, Language in the WordPress Dashboard.
                  # A list of valid codes used to represent the language can be found at http://www.rssboard.org/rss-language-codes.
    cloud         # Is a pointer to the RssCloud API which is a blog monitoring service supported by WordPress.com.
                  # It enables a supporting client to receive instant notification when the blog is updated.
                  # http://www.rssboard.org/rsscloud-interface
    image         # Is a logo belonging to the site that can be displayed by Rss clients. You can modify the logo under the General Settings,
                  # Blog Picture / Icon dialog in the Dashboard. There are strict size and image formats requirements imposed by the Rss standard.
                  # http://www.rssboard.org/rss-specification#ltimagegtSubelementOfLtchannelgt
    # <atom:link rel=”search”> Is a URL pointing to the Open Search description document supplied by WordPress. It enables supported Rss clients and web browsers an easy means to
    # provide search terms to the blog and receive results in a standardised XML format. http://www.opensearch.org/Specifications/OpenSearch/1.1#OpenSearch_description_document
    #
    # <atom:link rel=”pub”> Is a URL pointing to the Google designed pubsubhubbub notification service that is supported by WordPress. In my opinion this is easier to implement
    # and use then the alternative <cloud> service that offers similar functionality. http://code.google.com/p/pubsubhubbub/
  end

  # Import blog stuff
  blog do
    wxr_version   # This is our first example of an extended Rss element. We can recognise that it does not belong to the Rss specification
                  # as the element contains a colon. Left of the colon contains the elements extension while right is the element name.
                  # wp:wxr_version is the version number for the WordPress extension Rss.
    base_site_url # Is the root URL  of the WordPress hosting provider.
    base_blog_url # Is the root URL of the WordPress blog.

    # Contains a complete collection of categories associated with the blog. You can view and edit the list within the Dashboard under Posts,
    # Categories. Each category is given its own <category> element and contains the following 3 child elements.
    categories do
      cat_name          # The original name of the category contained within a <![CDDATA[   ]]>. The CDATA or character data enclosure tells
                        # the XML/Rss parser not to process the text contained within. This is a safety measure in case the text contains
                        # any illegal characters that could generate errors. http://www.w3schools.com/xml/xml_cdata.asp
      category_parent   # If the category belongs to a hierarchy then the parent category is listed.
      category_nicename # Is the category name in a URL friendly format.
    end

    # Contains a complete collection of the blog post tags. You can view and edit the post tags within the
    # Dashboard under Posts, Posts Tags. It contains the following 2 child elements.
    tags do
      tag_slug # Is the URL friendly name of the tag.
      tag_name # Is the original name of the tag contained within a character data enclosure.
    end
  end

  # Import all blog entries includes pages
  items do
    title          # Title of the post or page.
    link           # URL to the post or page.
    pub_date       # Time and date that the post was posted online.
    creator        # Lists the author of the post. The element is a Dublin Core Rss extension as the Rss specification doesn’t contain any suitable elements for this role.
    guid           # Is the globally unique identifier used for the identification of the blog post by Rss and WordPress clients. The isPermaLink=false attribute just means that this identifier is not a legitimate website URL and is not usable in a web browser.
    description    # In Rss documents this element contains the synopsis of the item but in WXR it is left blank.
    content        # Is the replacement for the restrictive Rss <description> element. Enclosed within a character data enclosure is the complete WordPress formatted blog post, HTML tags and all.
    excerpt        # This is a summary or description of the post often used by RSS/Atom feeds
    post_id        # This is an auto-incremental, numeric, unique identification number given to each post, article or page.
    post_date      # Time and date that the post was published.
    post_date_gmt  # Time and date in GMT that the post was published.
    comment_status # A value stating whether public access for posting comments is opened or closed.
    ping_status
    post_name      # Is a unique, URL friendly nicename based on the post title.
    status         # Publish status of the post with the options; ‘publish’, ‘draft’, ‘pending’,’private’.
    post_parent    # The numeric identification number if the post’s parent. This I think is applicable to WordPress pages which can be nested within each other.
    menu_order     # I assume is related to menu navigation of nested pages.
    post_type      # Post type either ‘post’, ‘page’,’media’.
    post_password  # A non-encrypted password used by WordPress to restrict reading access to the post.
    attachment_url # Url to post image
    is_sticky      # A numeric Boolean value (0 = false, 1 = true) to determine if the post as a sticky. A sticky post means the post will always be displayed at the top of any list of posts.

    post?  # Is this item is blog post?
    page?  # Is this item a page?
    media? # Is this item a media?

    publish?
    draft?
    pending?
    private?

    # Post metadata (Here's info about images)
    # Are containers for newer additions the WXR document format that have been introduced
    # after the original WXR specification. Each <wp:postmeta> element contains 2 child elements.
    postmeta do
      meta_key
      meta_value

      # Below is a list of the <wp:meta_key> references currently used by WXR.
      delicious          # is data related to the Delicious social bookmarking web service. http://www.delicious.com/
      geo_latitude       # is the positioning location of the author when submitted the post. The value is the latitude in degrees
                         # using the World Geodetic System 1984 (WGS84) datum. It seems to be based on the Google Gears Geolocation API.
                         # http://code.google.com/apis/gears/api_geolocation.html
      geo_longitude      # is the positioning location of the author when they submitted the post. The value is the longitude coordinates.
      geo_accuracy       # is the horizontal accuracy of the above positioning values in metres.
      geo_address        # is the address determined by the above geolocation data.
      geo_public         # is a Boolean numeric value that determines if the geolocation data should be displayed in the post.
      email_notification # is an unknown value related to the email notification service for posting comments.
      _wpas_done_yup     # is an unknown numeric Boolean value.
      _wpas_done_twitter # is an unknown numeric Boolean value related to Twitter.
      reddit             # is data related to the reddit social news web service. http://www.reddit.com/
      _edit_last         # is an unknown reference.
      _edit_lock         # is an unknown reference.
    end

    # Post categories
    # Each category associated with the blog is given 2 category elements.
    # The first element contains just the category as a name, while the second element contains
    # both the category name and the URL friendly nicename attribute.
    categories do
      name
      nicename
    end

    # Post tags
    tags do
      name
      nicename
    end

    # Post images
    # We get it from metadata where meta_key = _wp_attachment_metadata
    images do
      width
      height
      aperture
      credit
      camera
      caption
      created_timestamp
      copyright
      focal_length
      iso
      shutter_speed
      title
    end

    # Post comments
    comments :skip => [:spam, :pingback] do
      comment_id           # This is an auto-incremental, numeric, unique identification number given to each comment.
      comment_author       # The name of author who submitted the comment. The name value is contained within a character data enclosure.
      comment_author_email # An e-mail address provided by the author of the comment.
      comment_author_url   # The URL of the author’s website provided by the author of the comment.
      comment_author_ip    # The IP address belonging to the author of the comment. The IP address is automatically recorded by WordPress.
      comment_date         # The date and time local to the blog that the comment was posted.
      comment_date_gmt     # The date and time at GMT that the comment was posted.
      comment_content      # The comment text enclosed within a character data enclosure.
      comment_approved     # A numeric Boolean value to determine if the comment is displayed.
      comment_type         # The type of comment. If left blank it is classed as a normal comment
                           # otherwise a value of ‘pingback’ means it is a post request notification link. http://en.wikipedia.org/wiki/Pingback
      comment_parent       # The numeric identification of the parent comment used when the comment is a response to a pre-existing comment.
      comment_user_id      # A numeric identification belonging to the author if they were logged in when they submitted the comment.

      spam? # Is this comment a spam?
    end
  end

  # Import only blog pages
=begin
  pages do
    # All similar to items
  end

  # Import only blog posts
  posts do
    # All similar to items
  end
=end
end
