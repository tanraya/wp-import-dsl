=begin
Есть DSL вида:

WpImportDsl.import(filename) do
  # Итератор айтемов
  items do
    puts title # Печатаем заголовок айтема

    # Итератор комментариев айтема
    comments do
      puts comment_date # печатаем дату коммента
    end
  end
end

=end


module WpImportDsl
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

