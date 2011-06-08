module WpImportDsl
  def self.reader
    [
      {
          :title    => 'First item',
          :comments => [
              { :title => 'First comment of first item' },
              { :title => 'Second comment of first item' },
              { :title => 'Third comment of first item' }
          ]
      },
      {
          :title    => 'Second item',
          :comments => [
              { :title => 'First comment of second item' }
          ]
      },
    ]
  end

  def self.items(&block)
    puts :items
    instance_eval(&block)
  end

  def self.comments(&block)
    puts :comments
    instance_eval(&block)
  end

  def self.title
    :title
  end

  def self.import(&block)
    instance_eval(&block)
  end
end


#
#
#
WpImportDsl.import do
  # Итератор айтемов
  items do
    puts title # Печатаем заголовок айтема

    # Итератор комментариев айтема
    comments do
      puts title # печатаем дату коммента
    end
  end
end