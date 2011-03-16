desc "Reset"
task :reset do
  ENV['VERSION']= '0'
  Rake::Task['db:migrate'].invoke
  Rake::Task['db:migrate'].reenable
  ENV.delete 'VERSION'
  Rake::Task["db:migrate"].invoke
  Rake::Task["db:fixtures:load"].invoke
  [:approve_all_internships, :make_search_strings].each do |t|
    $build_type = t
    Rake::Task[t].reenable
    Rake::Task[t].invoke
  end

  puts "Reset HIDB"
end