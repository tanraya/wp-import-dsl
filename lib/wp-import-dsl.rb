module WpImportDsl
  # Move all autoloads here
  autoload :Item,     'wp-import-dsl/item'
  autoload :Comment,  'wp-import-dsl/comment'
  autoload :Rss,      'wp-import-dsl/rss'
  autoload :Blog,     'wp-import-dsl/blog'
  autoload :Category, 'wp-import-dsl/category'
  autoload :Image,    'wp-import-dsl/image'
  autoload :Tag,      'wp-import-dsl/tag'
  autoload :Wxr,      'wp-import-dsl/wxr'

  def self.import(source, &block)
    @@reader = Wxr::Reader.new(source)
    instance_eval(&block)
  end

  def self.items(&block)
    return unless self.reader.respond_to? :items

    self.reader.items.each do |item|
      i = Item.new(item)
      i.instance_eval(&block)
    end
  end

  def self.pages(&block)
    return unless self.reader.respond_to? :items

    self.reader.items.each do |item|
      i = Item.new(item, { :only => [ :page ] })
      i.instance_eval(&block)
    end
  end

  def self.posts(&block)
    return unless self.reader.respond_to? :items

    self.reader.items.each do |item|
      i = Item.new(item, { :only => [ :post ] })
      i.instance_eval(&block)
    end
  end

  def self.media(&block)
    return unless self.reader.respond_to? :items

    self.reader.items.each do |item|
      i = Item.new(item, { :only => [ :media ] })
      i.instance_eval(&block)
    end
  end


  def self.rss(&block)
    return unless self.reader.respond_to? :rss

    r = Rss.new(self.reader.rss)
    r.instance_eval(&block)
  end

  def self.blog(&block)
    return unless self.reader.respond_to? :blog

    b = Blog.new(self.reader.blog)
    b.instance_eval(&block)
  end

  def self.reader
    @@reader
  end
end

