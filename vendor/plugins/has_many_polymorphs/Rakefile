$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "bundler/version"
 
task :build do
  system "gem build bundler.gemspec"
end
 
task :release => :build do
  system "gem push bundler-#{Bunder::VERSION}"
end

desc "Run all the tests for every database adapter" 
task "test_all" do
  ['mysql', 'postgresql', 'sqlite3'].each do |adapter|
    ENV['DB'] = adapter
    ENV['PRODUCTION'] = nil
    STDERR.puts "#{'='*80}\nDevelopment mode for #{adapter}\n#{'='*80}"
    system("rake test:multi_rails:all")
  
    ENV['PRODUCTION'] = '1'
    STDERR.puts "#{'='*80}\nProduction mode for #{adapter}\n#{'='*80}"
    system("rake test:multi_rails:all")    
  end
end
