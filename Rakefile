require "rubygems"
require "rake"

begin
  require "jeweler"
  Jeweler::Tasks.new do |gem|
    gem.name = "ruck-glapp"
    gem.email = "tom@alltom.com"
    gem.homepage = "http://github.com/alltom/ruck-glapp"
    gem.authors = ["Tom Lieber"]
    gem.summary = %Q{ruck shreduler based on GLApp (a thin ruby-opengl)}
    gem.description = <<-EOF
      A ruck shreduler which runs in an OpenGL callback, with
      frame, keyboard, and mouse events.
    EOF
    gem.has_rdoc = false
    gem.add_dependency "ruck", ">= 0"
    gem.add_dependency "glapp", ">= 0"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end
