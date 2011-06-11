require 'nokogiri'

# TODO
# 1. Rails generator that generates wid:import rake task & prepared template with DSL
# 2. Prepared DSL for refinery blog or other blog systems
module WpImportDsl

  class Base
    attr_accessor :reader, :options

    def initialize(reader, options)
      self.reader  = reader
      self.options = options
    end

    def retrieve(key)
      typecast(self.reader.xpath(key).text)
    end

    def typecast(entity)
      entity = DateTime.parse(entity) if options[:as] == :datetime
      entity = entity.to_i if options[:as] == :integer
      entity = entity.to_i > 0 if options[:as] == :boolean
      entity
    end

    def self.attrs(options = {}, &block)
      @attrs_options ||= {}
      @attrs_options[:scope] = options[:scope].to_s
      instance_eval(&block)
    end

    def self.method_missing(method, *args, &block)
      options = args.shift || {}
      options[:scope] = @attrs_options[:scope] unless options.key? :scope
      options[:scope] = "#{options[:scope]}:" if options[:scope].to_s.size > 0

      class_eval %Q{
        def #{method}
          retrieve("#{options[:scope]}#{method}")
        end
      }

      unless options[:alias].nil?
        class_eval "alias #{options[:alias]} #{method}"
      end
    end

  private

    def exec_each(klass, xpath_query, options = {}, &block)
      self.reader.xpath(xpath_query).each do |x|
        instance = klass.new(x, options)
        instance.instance_eval(&block)
      end
    end
  end

  class Item < Base
    attrs :scope => :wp do
      title          :scope => nil
      link           :scope => nil
      pubDate        :scope => nil, :alias => :pub_date, :as => :datetime
      creator        :scope => :dc
      guid           :scope => nil
      description    :scope => nil
      post_id        :as => :integer
      post_date      :as => :datetime
      post_date_gmt  :as => :datetime
      comment_status
      ping_status
      post_name
      status
      post_parent    :as => :integer
      menu_order     :as => :integer
      post_type
      post_password
      attachment_url
      is_sticky      :as => :boolean
    end

    def comments(options = {}, &block)
      exec_each(Comment, 'wp:comment', options, &block)
    end

    def postmeta(options = {}, &block)
      exec_each(Postmeta, 'wp:postmeta', options, &block)
    end

    def categories(options = {}, &block)
      exec_each(Category, 'category', options, &block)
    end

    def tags(options = {}, &block)
      exec_each(Tag, 'tag', options, &block)
    end

    def images(options = {}, &block)
      
    end

    def content
      retrieve "content:encoded"
    end

    def excerpt
      retrieve "excerpt:encoded"
    end

    # Is this item a blog post?
    def post?
      self.post_type == 'post'
    end

    # Is this item a page?
    def page?
      self.post_type == 'page'
    end

    # Is this item a media?
    def media?
      self.post_type == 'media'
    end

    def publish?
      self.status == 'publish'
    end

    def draft?
      self.status == 'draft'
    end

    def pending?
      self.status == 'pending'
    end

    def private?
      self.status == 'private'
    end

    def sticky?
      self.is_sticky
    end
  end

  class Blog < Base
    attrs :scope => :wp do
      wxr_version
      base_site_url :alias => :site_url
      base_blog_url :alias => :blog_url
    end

    def tags(options = {}, &block)
      exec_each(Tag, 'wp:tag', options, &block)
    end

    def categories(options = {}, &block)
      exec_each(Category, 'wp:category', options, &block)
    end
  end

  class Postmeta < Base
    attrs :scope => :wp do
      wxr_version
      meta_key   :alias => :key
      meta_value :alias => :value
    end
  end

  class Rss < Base
    attrs do
      title
      description
      link
      pubDate :alias => :pub_date, :as => :datetime
      generator
      language
      cloud
      image
    end

    # TODO download image from specified url
    def image=(image_url)
      self.image = nil#File.new # mock
    end
  end

  class Tag < Base
    attrs :scope => :wp do
      tag_slug :alias => :slug
      tag_name :alias => :name
    end
  end

  class Category < Base
    attrs :scope => :wp do
      cat_name          :alias => :name
      category_parent   :alias => :parent
      category_nicename :alias => :nicename
    end
  end

  class Comment < Base
    attrs :scope => :wp do
      comment_id           :alias => :id, :scope => nil, :as => :integer # We can remove scope
      comment_author       :alias => :author
      comment_author_email :alias => :author_email
      comment_author_url   :alias => :author_url
      comment_author_IP    :alias => :author_ip
      comment_date         :alias => :date, :as => :datetime
      comment_date_gmt     :alias => :date_gmt, :as => :datetime
      comment_content      :alias => :content
      comment_approved     :alias => :approved, :as => :boolean
      comment_type         :alias => :type
      comment_parent       :alias => :parent, :as => :integer
      comment_user_id      :alias => :user_id, :as => :integer
    end

    def spam?
      self.comment_type == 'spam'
    end
  end

  class Image < Base

  end

  module Methods
    def self.items(options = {}, &block)
      self.exec_each(Item, 'item', options, &block)
    end

    def self.rss(options = {}, &block)
      self.exec(Rss, options, &block)
    end

    def self.blog(options = {}, &block)
      self.exec(Blog, options, &block)
    end

    def self.exec_each(klass, xpath_query, options = {}, &block)
      WpImportDsl.reader.xpath(xpath_query).each do |x|
        instance = klass.new(x, options)
        instance.instance_eval(&block)
      end
    end

    def self.exec(klass, options = {}, &block)
      instance = klass.new(WpImportDsl.reader, options)
      instance.instance_eval(&block)
    end
  end

  def self.import(source, &block)
    @@reader = Nokogiri::XML(File.open(source), nil, 'utf-8').xpath('/rss/channel')
    Methods.class_eval(&block)
  end

  def self.reader
    @@reader
  end
end

