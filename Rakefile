require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/gempackagetask'

spec = Gem::Specification.new do |s|
    s.name= "acts_as_money"
    s.version= "0.3.0"
    s.summary= "A fairly trivial plugin allowing easy serialisation of Money values (from the money gem) as attributes on activerecord objects"
    s.authors = ["Tim Cowlishaw", "Bryan Donovan", "Dmitry Zhelnin"]
    s.email = "dmitry.zhelnin@gmail.com"
    s.homepage = "http://github.com/whitered/acts_as_money"
    s.has_rdoc = false
    s.extra_rdoc_files = %w(README)
    s.rdoc_options = %w(--main README)
    s.files = %w(README) + Dir.glob("{test,tasks,lib/**/*}")
    s.require_paths = ["lib"]
    s.add_dependency("money")
    s.add_dependency("activerecord")
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
  file = File.dirname(__FILE__) + "/#{spec.name}.gemspec"
  File.open(file, "w") {|f| f << spec.to_ruby}
end

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the money plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end
