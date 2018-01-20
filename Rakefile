require "rspec/core/rake_task"

gem_name = "soya"
gem_version = Soya::VERSION

RSpec::Core::RakeTask.new(:spec)
task :default => :spec

desc "Build the gem"
task :build do
  sh("gem build #{gem_name}.gemspec")
end
