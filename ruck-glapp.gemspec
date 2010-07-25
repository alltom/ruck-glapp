# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ruck-glapp}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tom Lieber"]
  s.date = %q{2010-07-25}
  s.default_executable = %q{ruck_glapp}
  s.description = %q{      A ruck shreduler which runs in an OpenGL callback, with
      frame, keyboard, and mouse events.
}
  s.email = %q{tom@alltom.com}
  s.executables = ["ruck_glapp"]
  s.extra_rdoc_files = [
    "README"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "README",
     "Rakefile",
     "VERSION",
     "bin/ruck_glapp",
     "examples/ex01.rb",
     "examples/ex02.rb",
     "examples/ex03.rb",
     "lib/ruck/glapp.rb",
     "lib/ruck/glapp/glapp.rb",
     "ruck-glapp.gemspec"
  ]
  s.homepage = %q{http://github.com/alltom/ruck-glapp}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{ruck shreduler based on GLApp (a thin ruby-opengl)}
  s.test_files = [
    "examples/ex01.rb",
     "examples/ex02.rb",
     "examples/ex03.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ruck>, [">= 0"])
      s.add_runtime_dependency(%q<glapp>, [">= 0"])
    else
      s.add_dependency(%q<ruck>, [">= 0"])
      s.add_dependency(%q<glapp>, [">= 0"])
    end
  else
    s.add_dependency(%q<ruck>, [">= 0"])
    s.add_dependency(%q<glapp>, [">= 0"])
  end
end

