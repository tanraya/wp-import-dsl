module Dsl
  class Comment
    def initialize(comment)
      @comment = comment # Wrap it with WXR object
    end

    def method_missing(method, *args, &block)
      @comment[method]
    end
  end

  class Post
    def initialize(post)
      @post = post
    end

    def comments(&block)
      @post[:comments].each do |comment|
        c = Comment.new(comment)
        c.instance_eval(&block)
      end
    end

    def method_missing(method, *args, &block)
      @post[method]
    end
  end

  # Sample data
  def self.reader
    [
      # First post with 2 comments
      {
        :content  => 'Post 1 content',
        :comments => [
          { :content => 'Post 1 comment 1' },
          { :content => 'Post 1 comment 2' }
        ]
      },
      # Second post with 1 comment
      {
        :content  => 'Post 2 content',
        :comments => [ 
          { :content => 'Post 2 comment 1' }
        ]
      },
    ]
  end

  def self.import(&block)
    instance_eval(&block)
  end

  def self.posts(&block)
    self.reader.each do |post|
      p = Post.new(post)
      p.instance_eval(&block)
    end
  end
end

# Usage:
Dsl.import do
  # Iterator
  posts do
    # Output post content
    puts content

    # Iterator
    comments do
      # Output comment content
      puts content
    end
  end
end
