desc "Make search strings"
task :make_search_strings => [ :environment ] do | t |
  internship_fields = ["semester", "year", "industry", "company_name", "job_field", "city", "state", "country", "website", "user_id"]
  user_fields = ["user.first_name", "user.last_name", "user.email", "user.major", "user.username"]
  Internship.find(:all).each do |internship|
    string = []
    (internship_fields + user_fields).each{|x| string << eval("internship." + x).to_s.downcase if eval("internship." + x)}
  	internship.search_string = string.join(" ")
  	internship.save(false)
  end
  
  puts "Made search strings"
end