module WpImportDsl
  class Base
    def exec(klass, block_name, options = {}, &block)
      return unless @item.respond_to? block_name

      @item.send(block_name).each do |x|
        instance = klass.new(x, options)
        instance.instance_eval(&block)
      end
    end
  end

  autoload :Item,     'wp-import-dsl/item'
  autoload :Comment,  'wp-import-dsl/comment'
  autoload :Rss,      'wp-import-dsl/rss'
  autoload :Blog,     'wp-import-dsl/blog'
  autoload :Category, 'wp-import-dsl/category'
  autoload :Image,    'wp-import-dsl/image'
  autoload :Tag,      'wp-import-dsl/tag'
  autoload :Wxr,      'wp-import-dsl/wxr'

  module Methods
    def self.items(options, &block)
      self.exec_each(Item, :items, options, &block)
    end

    def self.pages(options = { :only => [ :page ] }, &block)
      self.exec_each(Item, :items, options, &block)
    end

    def self.posts(options = { :only => [ :post ] }, &block)
      self.exec_each(Item, :items, options, &block)
    end

    def self.media(options = { :only => [ :media ] }, &block)
      self.exec_each(Item, :items, options, &block)
    end

    def self.rss(options, &block)
      self.exec(Rss, :rss, options, &block)
    end

    def self.blog(options, &block)
      self.exec(Blog, :blog, options, &block)
    end

    def self.exec_each(klass, block_name, options = {}, &block)
      return unless WpImportDsl.reader.respond_to? block_name
      WpImportDsl.reader.send(block_name).each do |x|
        instance = klass.new(x, options)
        instance.instance_eval(&block)
      end
    end

    def self.exec(klass, block_name, options = {}, &block)
      return unless WpImportDsl.reader.respond_to? block_name
      instance = klass.new(WpImportDsl.reader.send(block_name), options)
      instance.instance_eval(&block)
    end
  end

  def self.import(source, &block)
    @@reader = Wxr::Reader.new(source)
    Methods.class_eval(&block)
  end

  def self.reader
    @@reader
  end
end

