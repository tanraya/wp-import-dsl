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

