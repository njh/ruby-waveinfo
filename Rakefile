require 'rubygems'
require 'rake'
require 'rake/clean'
require 'rake/gempackagetask'
require 'rake/rdoctask'
require 'rake/testtask'

NAME = "waveinfo"
VERS = "0.0.1"
CLEAN.include ['pkg', 'rdoc']

Gem::manage_gems

spec = Gem::Specification.new do |s|
  s.name              = NAME
  s.version           = VERS
  s.author            = "Nicholas J Humfrey"
  s.email             = "njh@aelius.com"
  s.homepage          = "http://waveinfo.rubyforge.org"
  s.platform          = Gem::Platform::RUBY
  s.summary           = "Pure-ruby gem to get the information from the headers of Wave (.wav) files." 
  s.rubyforge_project = "waveinfo" 
  s.description       = "waveinfo is a pure-ruby gem to get the information from the headers of Wave (.wav) files."
  s.files             = FileList["Rakefile", "lib/wavinfo.rb", "example.rb"]
  s.require_path      = "lib"
  
  # rdoc
  s.has_rdoc          = true
  s.extra_rdoc_files  = ["README", "COPYING"]
  
  # Dependencies
  s.add_dependency "rake"
end

desc "Default: package up the gem."
task :default => :package

task :build_package => [:repackage]
Rake::GemPackageTask.new(spec) do |pkg|
  pkg.need_zip = false
  pkg.need_tar = true
  pkg.gem_spec = spec
end

desc "Run :package and install the resulting .gem"
task :install => :package do
  sh %{sudo gem install --local pkg/#{NAME}-#{VERS}.gem}
end

desc "Run :clean and uninstall the .gem"
task :uninstall => :clean do
  sh %{sudo gem uninstall #{NAME}}
end



## Testing
desc "Run all the specification tests"
Rake::TestTask.new(:spec) do |t|
  t.warning = true
  t.verbose = true
  t.pattern = 'spec/*_spec.rb'
end
  
desc "Check the syntax of all ruby files"
task :check_syntax do
  `find . -name "*.rb" |xargs -n1 ruby -c |grep -v "Syntax OK"`
  puts "* Done"
end

desc "Create rspec report as HTML"
task :rspec_html do
  sh %{spec -f html spec/waveinfo_spec.rb > rspec_results.html}
end

## Documentation
desc "Generate documentation for the library"
Rake::RDocTask.new("rdoc") { |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = "waveinfo Documentation"
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.main = "README"
  rdoc.rdoc_files.include("README", "COPYING", "lib/waveinfo.rb")
}

desc "Upload rdoc to rubyforge"
task :upload_rdoc => [:rdoc] do
  sh %{/usr/bin/scp -r -p rdoc/* waveinfo.rubyforge.org:/var/www/gforge-projects/waveinfo}
end
