begin
  require 'spec'
rescue LoadError
  require 'rubygems'
  gem 'rspec'
  require 'spec'
end

$:.unshift(File.dirname(__FILE__) + '/../lib')

def sample_path(name)
  File.join(File.dirname(__FILE__), '..', 'samples', name + '.wav')
end
