desc "Build all"
task :build_all do
  [:approve_all_internships, :make_search_strings].each do |t|
    $build_type = t
    Rake::Task[t].reenable
    Rake::Task[t].invoke
  end

  puts "Made search strings"
end