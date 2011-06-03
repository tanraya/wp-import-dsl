=begin
module ProductKinds
  module Props
    class PropOptions
      attr_accessor :as, :default, :collection

      def add(options)
        options.each_pair do |option, value|
          send "#{option}=".to_sym, value
        end
      end
    end

    class Prop
      attr_accessor :name

      def options
        @options
      end

      def options=(options)
        @options = PropOptions.new
        @options.add(options)
      end
    end

    module ClassMethods
      def self.extended(base)
        class_eval { attr_accessor :props, :current_group, :options }
      end

      # Set up group
      def group(name, &block)
        self.props       ||= {}
        self.options     ||= {}
        self.current_group = name;

        if block_given?
          instance_eval(&block)
        end
      end

      def prop(name, *options)
        self.props[self.current_group] ||= []

        prop = Prop.new
        prop.name    = name;
        prop.options = options.extract_options!

        self.props[self.current_group] << prop
        attr_accessor name
      end
    end
  end

  class Base < Tableless
    extend  Props::ClassMethods

    group :common do
      prop :name,  :as => :string
      prop :price, :as => :numeric
    end
  end
end
=end

module WpImportDsl
  autoload :WxrReader, 'wp-import-dsl/wxr_reader'

  module Builder
    module Rss
      module ClassMethods
        def self.extended(base)
          class_eval { attr_accessor :link }
        end

        def link
          "Hell world!"
        end
      end
    end

    module Blog
      # todo
    end

    module Items
      # todo
    end
  end

  module ClassMethods
    extend Builder::Rss::ClassMethods

    def rss(&block)
      class_eval(&block) if block_given?
      #puts 'Fffuuuu'
    end
  end

  #extend Props::ClassMethods
  extend ClassMethods

  def self.import(&block)
    instance_eval(&block) if block_given?
  end
end

# DSL example
WpImportDsl.import do
  rss do
    link # => "Hell world!"
  end
end
