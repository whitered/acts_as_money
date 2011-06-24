# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{acts_as_money}
  s.version = "0.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tim Cowlishaw", "Bryan Donovan", "Dmitry Zhelnin"]
  s.date = %q{2011-06-24}
  s.email = %q{dmitry.zhelnin@gmail.com}
  s.extra_rdoc_files = ["README"]
  s.files = ["README", "test", "lib/acts_as_money.rb"]
  s.homepage = %q{http://github.com/whitered/acts_as_money}
  s.rdoc_options = ["--main", "README"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{A fairly trivial plugin allowing easy serialisation of Money values (from the money gem) as attributes on activerecord objects}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<money>, [">= 0"])
      s.add_runtime_dependency(%q<activerecord>, [">= 0"])
    else
      s.add_dependency(%q<money>, [">= 0"])
      s.add_dependency(%q<activerecord>, [">= 0"])
    end
  else
    s.add_dependency(%q<money>, [">= 0"])
    s.add_dependency(%q<activerecord>, [">= 0"])
  end
end
