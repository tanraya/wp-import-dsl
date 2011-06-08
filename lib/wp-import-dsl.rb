module WpImportDsl
  autoload :Item,     'wp-import-dsl/item'
  autoload :Comment,  'wp-import-dsl/comment'
  autoload :Rss,      'wp-import-dsl/rss'
  autoload :Blog,     'wp-import-dsl/blog'
  autoload :Category, 'wp-import-dsl/category'
  autoload :Image,    'wp-import-dsl/image'
  autoload :Tag,      'wp-import-dsl/tag'
  autoload :Wxr,      'wp-import-dsl/wxr'

  module Methods
    def self.items(&block)
      self.exec_each(Item, :items, {}, &block)
    end

    def self.pages(&block)
      self.exec_each(Item, :items, { :only => [ :page ] }, &block)
    end

    def self.posts(&block)
      self.exec_each(Item, :items, { :only => [ :post ] }, &block)
    end

    def self.media(&block)
      self.exec_each(Item, :items, { :only => [ :media ] }, &block)
    end

    def self.rss(&block)
      self.exec(Rss, :rss, {}, &block)
    end

    def self.blog(&block)
      self.exec(Blog, :blog, {}, &block)
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

