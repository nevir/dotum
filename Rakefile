#!/usr/bin/env rake
require "bundler/gem_tasks"

PROJECT_ROOT = File.expand_path("..", __FILE__)
Dir["#{PROJECT_ROOT}/tasks/**/*.rake"].each do |path|
  load path
end

$LOAD_PATH.unshift File.join(PROJECT_ROOT, "lib")


desc "Run the full test suite"
task :default => [:spec, :"spec:mutate"]
