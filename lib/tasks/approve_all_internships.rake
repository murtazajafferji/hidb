desc "Approve all internships"
task :approve_all_internships => [ :environment ] do | t |
  Internship.find(:all).each do |internship|
  	internship.approved = true
  	internship.save(false)
  end
  
  puts "All internships approved"
end