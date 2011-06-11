require 'rubygems'
require 'bundler/setup'
require 'wp-import-dsl'

########################################################################################################################
# DSL example
WpImportDsl.import(File.dirname(__FILE__) + '/source/vanilla.xml') do
=begin
  rss({}) do
    puts title         # Contains the site title of the blog.
    puts description   # Is a tagline that can be modified in the Dashboard under General Settings.
    puts link          # Is the URL of the blog as determined by WordPress.
    puts pub_date      # Was the time and date that the WXR document was created. It is in the RFC-822 format http://asg.web.cmu.edu/rfc/rfc822.html
                  # as required by the Rss standard. The format should be self explanatory except for the last numeric value which represents
                  # the local differential from GMT using a +/-hhmm format. Plus 2 hours from GMT would be represented as +0200.
                  # The WordPress time zone can be changed in the Dashboard under General Settings, Timezone.
    puts generator     # Is the name or a URL pointing to the homepage of the application that was used to create the Rss document.
    puts language      # Is the primary language the blog is written in as determined by General Setting, Language in the WordPress Dashboard.
                  # A list of valid codes used to represent the language can be found at http://www.rssboard.org/rss-language-codes.
    puts cloud         # Is a pointer to the RssCloud API which is a blog monitoring service supported by WordPress.com.
                  # It enables a supporting client to receive instant notification when the blog is updated.
                  # http://www.rssboard.org/rsscloud-interface
    puts image         # Is a logo belonging to the site that can be displayed by Rss clients. You can modify the logo under the General Settings,
                  # Blog Picture / Icon dialog in the Dashboard. There are strict size and image formats requirements imposed by the Rss standard.
                  # http://www.rssboard.org/rss-specification#ltimagegtSubelementOfLtchannelgt
    # <atom:link rel=”search”> Is a URL pointing to the Open Search description document supplied by WordPress. It enables supported Rss clients and web browsers an easy means to
    # provide search terms to the blog and receive results in a standardised XML format. http://www.opensearch.org/Specifications/OpenSearch/1.1#OpenSearch_description_document
    #
    # <atom:link rel=”pub”> Is a URL pointing to the Google designed pubsubhubbub notification service that is supported by WordPress. In my opinion this is easier to implement
    # and use then the alternative <cloud> service that offers similar functionality. http://code.google.com/p/pubsubhubbub/
  end

  # Import blog stuff
  blog({}) do
    puts wxr_version   # This is our first example of an extended Rss element. We can recognise that it does not belong to the Rss specification
                  # as the element contains a colon. Left of the colon contains the elements extension while right is the element name.
                  # wp:wxr_version is the version number for the WordPress extension Rss.
    puts base_site_url # Is the root URL  of the WordPress hosting provider.
    puts base_blog_url # Is the root URL of the WordPress blog.

    # Contains a complete collection of categories associated with the blog. You can view and edit the list within the Dashboard under Posts,
    # Categories. Each category is given its own <category> element and contains the following 3 child elements.

    categories({}) do
      puts 'fuck!'
      puts cat_name          # The original name of the category contained within a <![CDDATA[   ]]>. The CDATA or character data enclosure tells
                        # the XML/Rss parser not to process the text contained within. This is a safety measure in case the text contains
                        # any illegal characters that could generate errors. http://www.w3schools.com/xml/xml_cdata.asp
      puts category_parent   # If the category belongs to a hierarchy then the parent category is listed.
      puts category_nicename # Is the category name in a URL friendly format.
    end

    # Contains a complete collection of the blog post tags. You can view and edit the post tags within the
    # Dashboard under Posts, Posts Tags. It contains the following 2 child elements.
    tags({}) do
      tag_slug # Is the URL friendly name of the tag.
      tag_name # Is the original name of the tag contained within a character data enclosure.
    end

  end
=end
  # Import all blog entries includes pages
  items do

#    puts item.title
    puts title          # Title of the post or page.
    puts link           # URL to the post or page.
    puts pubDate       # Time and date that the post was posted online.
    puts creator        # Lists the author of the post. The element is a Dublin Core Rss extension as the Rss specification doesn’t contain any suitable elements for this role.
    puts guid           # Is the globally unique identifier used for the identification of the blog post by Rss and WordPress clients. The isPermaLink=false attribute just means that this identifier is not a legitimate website URL and is not usable in a web browser.
    puts description    # In Rss documents this element contains the synopsis of the item but in WXR it is left blank.
    puts content        # Is the replacement for the restrictive Rss <description> element. Enclosed within a character data enclosure is the complete WordPress formatted blog post, HTML tags and all.
    puts excerpt        # This is a summary or description of the post often used by RSS/Atom feeds
    puts post_id        # This is an auto-incremental, numeric, unique identification number given to each post, article or page.
    puts post_date      # Time and date that the post was published.
    puts post_date_gmt  # Time and date in GMT that the post was published.
    puts comment_status # A value stating whether public access for posting comments is opened or closed.
    puts ping_status
    puts post_name      # Is a unique, URL friendly nicename based on the post title.
    puts status         # Publish status of the post with the options; ‘publish’, ‘draft’, ‘pending’,’private’.
    puts post_parent    # The numeric identification number if the post’s parent. This I think is applicable to WordPress pages which can be nested within each other.
    puts menu_order     # I assume is related to menu navigation of nested pages.
    puts post_type      # Post type either ‘post’, ‘page’,’media’.
    puts post_password  # A non-encrypted password used by WordPress to restrict reading access to the post.
    puts attachment_url # Url to post image
    puts is_sticky      # A numeric Boolean value (0 = false, 1 = true) to determine if the post as a sticky. A sticky post means the post will always be displayed at the top of any list of posts.

    puts post?  # Is this item is blog post?
    puts page?  # Is this item a page?
    puts media? # Is this item a media?

    puts publish?
    puts draft?
    puts pending?
    puts private?

    # Post metadata (Here's info about images)
    # Are containers for newer additions the WXR document format that have been introduced
    # after the original WXR specification. Each <wp:postmeta> element contains 2 child elements.
    postmeta do
      puts meta_key
      puts meta_value
=begin
      # Below is a list of the <wp:meta_key> references currently used by WXR.
      puts delicious          # is data related to the Delicious social bookmarking web service. http://www.delicious.com/
      puts geo_latitude       # is the positioning location of the author when submitted the post. The value is the latitude in degrees
                         # using the World Geodetic System 1984 (WGS84) datum. It seems to be based on the Google Gears Geolocation API.
                         # http://code.google.com/apis/gears/api_geolocation.html
      puts geo_longitude      # is the positioning location of the author when they submitted the post. The value is the longitude coordinates.
      puts geo_accuracy       # is the horizontal accuracy of the above positioning values in metres.
      puts geo_address        # is the address determined by the above geolocation data.
      puts geo_public         # is a Boolean numeric value that determines if the geolocation data should be displayed in the post.
      puts email_notification # is an unknown value related to the email notification service for posting comments.
      puts _wpas_done_yup     # is an unknown numeric Boolean value.
      puts _wpas_done_twitter # is an unknown numeric Boolean value related to Twitter.
      puts reddit             # is data related to the reddit social news web service. http://www.reddit.com/
      puts _edit_last         # is an unknown reference.
      puts _edit_lock         # is an unknown reference.
=end
    end

    # Post categories
    # Each category associated with the blog is given 2 category elements.
    # The first element contains just the category as a name, while the second element contains
    # both the category name and the URL friendly nicename attribute.
    categories do
      puts name
      puts nicename
    end

    # Post tags
    tags do
      puts name
      puts nicename
    end

    # Post images
    # We get it from metadata where meta_key = _wp_attachment_metadata
    images do
      puts width
      puts height
      puts aperture
      puts credit
      puts camera
      puts caption
      puts created_timestamp
      puts copyright
      puts focal_length
      puts iso
      puts shutter_speed
      puts title
    end

    # Post comments
    comments do
      puts comment_id           # This is an auto-incremental, numeric, unique identification number given to each comment.
      puts comment_author       # The name of author who submitted the comment. The name value is contained within a character data enclosure.
      puts comment_author_email # An e-mail address provided by the author of the comment.
      puts comment_author_url   # The URL of the author’s website provided by the author of the comment.
      puts comment_author_IP    # The IP address belonging to the author of the comment. The IP address is automatically recorded by WordPress.
      puts comment_date         # The date and time local to the blog that the comment was posted.
      puts comment_date_gmt     # The date and time at GMT that the comment was posted.
      puts comment_content      # The comment text enclosed within a character data enclosure.
      puts comment_approved     # A numeric Boolean value to determine if the comment is displayed.
      puts comment_type         # The type of comment. If left blank it is classed as a normal comment
                           # otherwise a value of ‘pingback’ means it is a post request notification link. http://en.wikipedia.org/wiki/Pingback
      puts comment_parent       # The numeric identification of the parent comment used when the comment is a response to a pre-existing comment.
      puts comment_user_id      # A numeric identification belonging to the author if they were logged in when they submitted the comment.

      puts spam? # Is this comment a spam?
    end
  end
end
