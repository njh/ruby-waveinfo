$:.unshift(File.join(File.dirname(__FILE__),'..','lib'))

require 'rubygems'
require 'bundler'

Bundler.require(:default, :development)

def sample_path(name)
  File.join(File.dirname(__FILE__), '..', 'samples', name + '.wav')
end
