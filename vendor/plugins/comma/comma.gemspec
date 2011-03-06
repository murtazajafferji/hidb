# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{comma}
  s.version = "0.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Marcus Crafter"]
  s.date = %q{2010-10-19}
  s.description = %q{Ruby Comma Seperated Values generation library}
  s.email = %q{crafterm@redartisan.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    ".gitignore",
     "MIT-LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "comma.gemspec",
     "init.rb",
     "lib/comma.rb",
     "lib/comma/array.rb",
     "lib/comma/association_proxy.rb",
     "lib/comma/extractors.rb",
     "lib/comma/generator.rb",
     "lib/comma/named_scope.rb",
     "lib/comma/object.rb",
     "lib/comma/render_as_csv.rb",
     "spec/comma/ar_spec.rb",
     "spec/comma/comma_spec.rb",
     "spec/comma/extractors_spec.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb",
     "sudo"
  ]
  s.homepage = %q{http://github.com/crafterm/comma}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{comma}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Ruby Comma Seperated Values generation library}
  s.test_files = [
    "spec/comma/ar_spec.rb",
     "spec/comma/comma_spec.rb",
     "spec/comma/extractors_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_runtime_dependency(%q<activesupport>, [">= 2.2.2"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_dependency(%q<activesupport>, [">= 2.2.2"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
    s.add_dependency(%q<activesupport>, [">= 2.2.2"])
  end
end

