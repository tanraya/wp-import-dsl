# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "wp-import-dsl/version"

Gem::Specification.new do |s|
  s.name        = "wp-import-dsl"
  s.version     = Wp::Import::Dsl::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["TODO: Write your name"]
  s.email       = ["TODO: Write your email address"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "wp-import-dsl"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib", "lib/wp-import-dsl"]

  s.add_dependency "nokogiri"
end
