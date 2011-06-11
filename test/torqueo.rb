require 'rubygems'
require 'bundler/setup'
require 'wp-import-dsl'

########################################################################################################################
# DSL example
#source = File.dirname(__FILE__) + '/source/vanilla.xml'
source = File.dirname(__FILE__) + '/source/wordpress.2011-06-03.xml'
WpImportDsl.import(source) do
  items do
    next unless post? && publish?
    
    puts title
  end
end
