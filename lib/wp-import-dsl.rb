module WpImportDsl
  # Move all autoloads here
  autoload :Rss,   'wp-import-dsl/rss'
  autoload :Blog,  'wp-import-dsl/blog'
  autoload :Items, 'wp-import-dsl/items'
  autoload :Wxr,   'wp-import-dsl/wxr'

  extend Rss::ClassMethods
  extend Blog::ClassMethods
  extend Items::ClassMethods

  def self.import(source, &block)
    @@reader = Wxr::Reader.new(source)
    instance_eval(&block) if block_given?
  end

  def self.reader
    @@reader
  end
end

