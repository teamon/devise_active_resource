# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "devise_active_resource"
  s.version     = "0.1"
  s.summary     = %Q{Support for using ActiveResource with devise}
  s.homepage    = "http://github.com/teamon/devise_active_resource"
  s.files       = Dir.glob("lib/**/*") + %w(devise_active_resource.gemspec)
  s.test_files  = Dir.glob("test/**/*")

  s.add_dependency 'devise', '>= 1.2'
end
