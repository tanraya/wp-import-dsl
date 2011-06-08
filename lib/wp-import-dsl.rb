module WpImportDsl
  autoload :Wxr, 'wp-import-dsl/wxr'

  class Base
    def initialize(data, options)
      @data    = data
      @options = options
    end

    def tags(options, &block)
      exec_each(Tag, :tags, options, &block)
    end

    def categories(options, &block)
      exec_each(Category, :categories, options, &block)
    end

    def method_missing(method, *args, &block)
      @data.send(method) if @data.respond_to? method
    end

  private

    def exec_each(klass, block_name, options = {}, &block)
      return unless @data.respond_to? block_name

      @data.send(block_name).each do |x|
        instance = klass.new(x, options)
        instance.instance_eval(&block)
      end
    end
  end

  class Item < Base
    def comments(options, &block)
      exec_each(Comment, :comments, options, &block)
    end
  end

  class Blog     < Base; end
  class Postmeta < Base; end
  class Rss      < Base; end
  class Tag      < Base; end
  class Category < Base; end
  class Comment  < Base; end
  class Image    < Base; end

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

