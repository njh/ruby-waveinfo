#!/usr/bin/env ruby -rubygems
# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "waveinfo/version"

Gem::Specification.new do |gem|
  gem.name        = 'waveinfo'
  gem.version     = WaveInfo::VERSION
  gem.author      = 'Nicholas J Humfrey'
  gem.email       = 'njh@aelius.com'
  gem.homepage    = 'http://github.com/njh/ruby-waveinfo'
  gem.summary     = 'Pure-ruby gem to get the information from the headers of Wave (.wav) files.'
  gem.description = 'waveinfo is a pure-ruby gem to get the information from the headers of Wave (.wav) files.'
  gem.license     = 'Ruby' if gem.respond_to?(:license=)

  gem.rubyforge_project = 'waveinfo'

  gem.files         = %w(README.md COPYING GPL) + Dir.glob('lib/**/*.rb')
  gem.test_files    = Dir.glob('spec/*_spec.rb')
  gem.executables   = %w(waveinfo)
  gem.require_paths = %w(lib)

  gem.add_development_dependency 'bundler',     '>= 1.0.14'
  gem.add_development_dependency 'yard',        '>= 0.7.2'
  gem.add_development_dependency 'rake',        '>= 0.8.7'
  gem.add_development_dependency 'rspec',       '>= 2.6.0'
end
