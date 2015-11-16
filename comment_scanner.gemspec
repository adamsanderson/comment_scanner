# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'comment_scanner/version'

Gem::Specification.new do |spec|
  spec.name          = "comment_scanner"
  spec.version       = CommentScanner::VERSION
  spec.authors       = ["Adam Sanderson"]
  spec.email         = ["netghost@gmail.com"]

  spec.summary       = "Detect comment blocks in Ruby source."
  spec.description   = "Detects leading and trailing comment blocks in Ruby source.  This may be useful for annotating exception and profiling traces."
  spec.homepage      = "https://github.com/adamsanderson/comment_scanner"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
end
