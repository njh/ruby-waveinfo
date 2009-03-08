begin
  require 'spec'
rescue LoadError
  require 'rubygems'
  gem 'rspec'
  require 'spec'
end

$:.unshift(File.dirname(__FILE__) + '/../lib')

def fixture_path(name)
  File.join(File.dirname(__FILE__), 'fixtures', name + '.wav')
end
