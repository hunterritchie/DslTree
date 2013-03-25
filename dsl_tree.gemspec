

$:.push File.expand_path('../lib', __FILE__)
require 'dsl_tree/version'

Gem::Specification.new do |s|
  s.name      = 'dsl_tree'
  s.version   = DslTree::VERSION 
  s.authors   = ['Hunter Ritchie']
  s.email     = ['hunter.ritchie@redhat.com']
  s.homepage  = ''
  s.summary   = %q{A library for generating a DSL}
  s.description   = %q{A library for generating a DSL that creates objects in a tree data structure}
  s.rubyforge_project  = ''

  s.files         = Dir.glob('lib/**/*.rb')
  s.require_paths = ['lib']
end

