require 'date'
user_output = File.new("users.yml", 'w')
internship_output = File.new("internships.yml", 'w')

FIRST_NAME = ["James", "John", "Robert", "Michael", "William", "David", "Richard", "Charles", "Joseph", "Thomas", "Christopher", "Daniel", "Paul", "Mark", "Donald", "George", "Kenneth", "Steven", "Edward", "Brian", "Ronald", "Anthony", "Kevin", "Jason", "Matthew", "Gary", "Timothy", "Jose", "Larry", "Jeffrey", "Frank", "Scott", "Eric", "Stephen", "Andrew", "Raymond", "Gregory", "Joshua", "Jerry", "Dennis", "Walter", "Patrick", "Peter", "Harold", "Douglas", "Henry", "Carl", "Arthur", "Ryan", "Roger", "Joe", "Juan", "Jack", "Albert", "Jonathan", "Justin", "Terry", "Gerald", "Keith", "Samuel", "Willie", "Ralph", "Lawrence", "Nicholas", "Roy", "Benjamin", "Bruce", "Brandon", "Adam", "Harry", "Fred", "Wayne", "Billy", "Steve", "Louis", "Jeremy", "Aaron", "Randy", "Howard", "Eugene", "Carlos", "Russell", "Bobby", "Victor", "Martin", "Ernest", "Phillip", "Todd", "Jesse", "Craig", "Alan", "Shawn", "Clarence", "Sean", "Philip", "Chris", "Johnny", "Earl", "Jimmy", "Antonio", "Danny", "Bryan", "Tony", "Luis", "Mike", "Stanley", "Leonard", "Nathan", "Dale", "Manuel", "Rodney", "Curtis", "Norman", "Allen", "Marvin", "Vincent", "Glenn", "Jeffery", "Travis", "Jeff", "Chad", "Jacob", "Lee", "Melvin", "Alfred", "Kyle", "Francis", "Bradley", "Jesus", "Herbert", "Frederick", "Ray", "Joel", "Edwin", "Don", "Eddie", "Ricky", "Troy", "Randall", "Barry", "Alexander", "Bernard", "Mario", "Leroy", "Francisco", "Marcus", "Micheal", "Theodore", "Clifford", "Miguel", "Oscar", "Jay", "Jim", "Tom", "Calvin", "Alex", "Jon", "Ronnie", "Bill", "Lloyd", "Tommy", "Leon", "Derek", "Warren", "Darrell", "Jerome", "Floyd", "Leo", "Alvin", "Tim", "Wesley", "Gordon", "Dean", "Greg", "Jorge", "Dustin", "Pedro", "Derrick", "Dan", "Lewis", "Zachary", "Corey", "Herman", "Maurice", "Vernon", "Roberto", "Clyde", "Glen", "Hector", "Shane", "Ricardo", "Sam", "Rick", "Lester", "Brent", "Ramon", "Charlie", "Tyler", "Gilbert", "Gene", "Marc", "Reginald", "Ruben", "Brett", "Angel", "Nathaniel", "Rafael", "Leslie", "Edgar", "Milton", "Raul", "Ben", "Chester", "Cecil", "Duane", "Franklin", "Andre", "Elmer", "Brad", "Gabriel", "Ron", "Mitchell", "Roland", "Arnold", "Harvey", "Jared", "Adrian", "Karl", "Cory", "Claude", "Erik", "Darryl", "Jamie", "Neil", "Jessie", "Christian", "Javier", "Fernando", "Clinton", "Ted", "Mathew", "Tyrone", "Darren", "Lonnie", "Lance", "Cody", "Julio", "Kelly", "Kurt", "Allan", "Nelson", "Guy", "Clayton", "Hugh", "Max", "Dwayne", "Dwight", "Armando", "Felix", "Jimmie", "Everett", "Jordan", "Ian", "Wallace", "Ken", "Bob", "Jaime", "Casey", "Alfredo", "Alberto", "Dave", "Ivan", "Johnnie", "Sidney", "Byron", "Julian", "Isaac", "Morris", "Clifton", "Willard", "Daryl", "Ross", "Virgil", "Andy", "Marshall", "Salvador", "Perry", "Kirk", "Sergio", "Marion", "Tracy", "Seth", "Kent", "Terrance", "Rene", "Eduardo", "Terrence", "Enrique", "Freddie", "Wade"]
LAST_NAME = ["Smith", "Johnson", "Williams", "Jones", "Brown", "Davis", "Miller", "Wilson", "Moore", "Taylor", "Anderson", "Thomas", "Jackson", "White", "Harris", "Martin", "Thompson", "Garcia", "Martinez", "Robinson", "Clark", "Rodriguez", "Lewis", "Lee", "Walker", "Hall", "Allen", "Young", "Hernandez", "King", "Wright", "Lopez", "Hill", "Scott", "Green", "Adams", "Baker", "Gonzalez", "Nelson", "Carter", "Mitchell", "Perez", "Roberts", "Turner", "Phillips", "Campbell", "Parker", "Evans", "Edwards", "Collins", "Stewart", "Sanchez", "Morris", "Rogers", "Reed", "Cook", "Morgan", "Bell", "Murphy", "Bailey", "Rivera", "Cooper", "Richardson", "Cox", "Howard", "Ward", "Torres", "Peterson", "Gray", "Ramirez", "James", "Watson", "Brooks", "Kelly", "Sanders", "Price", "Bennett", "Wood", "Barnes", "Ross", "Henderson", "Coleman", "Jenkins", "Perry", "Powell", "Long", "Patterson", "Hughes", "Flores", "Washington", "Butler", "Simmons", "Foster", "Gonzales", "Bryant", "Alexander", "Russell", "Griffin", "Diaz", "Hayes", "Myers", "Ford", "Hamilton", "Graham", "Sullivan", "Wallace", "Woods", "Cole", "West", "Jordan", "Owens", "Reynolds", "Fisher", "Ellis", "Harrison", "Gibson", "Mcdonald", "Cruz", "Marshall", "Ortiz", "Gomez", "Murray", "Freeman", "Wells", "Webb", "Simpson", "Stevens", "Tucker", "Porter", "Hunter", "Hicks", "Crawford", "Henry", "Boyd", "Mason", "Morales", "Kennedy", "Warren", "Dixon", "Ramos", "Reyes", "Burns", "Gordon", "Shaw", "Holmes", "Rice", "Robertson", "Hunt", "Black", "Daniels", "Palmer", "Mills", "Nichols", "Grant", "Knight", "Ferguson", "Rose", "Stone", "Hawkins", "Dunn", "Perkins", "Hudson", "Spencer", "Gardner", "Stephens", "Payne", "Pierce", "Berry", "Matthews", "Arnold", "Wagner", "Willis", "Ray", "Watkins", "Olson", "Carroll", "Duncan", "Snyder", "Hart", "Cunningham", "Bradley", "Lane", "Andrews", "Ruiz", "Harper", "Fox", "Riley", "Armstrong", "Carpenter", "Weaver", "Greene", "Lawrence", "Elliott", "Chavez", "Sims", "Austin", "Peters", "Kelley", "Franklin", "Lawson", "Fields", "Gutierrez", "Ryan", "Schmidt", "Carr", "Vasquez", "Castillo", "Wheeler", "Chapman", "Oliver", "Montgomery", "Richards", "Williamson", "Johnston", "Banks", "Meyer", "Bishop", "Mccoy", "Howell", "Alvarez", "Morrison", "Hansen", "Fernandez", "Garza", "Harvey", "Little", "Burton", "Stanley", "Nguyen", "George", "Jacobs", "Reid", "Kim", "Fuller", "Lynch", "Dean", "Gilbert", "Garrett", "Romero", "Welch", "Larson", "Frazier", "Burke", "Hanson", "Day", "Mendoza", "Moreno", "Bowman", "Medina", "Fowler", "Brewer", "Hoffman", "Carlson", "Silva", "Pearson", "Holland", "Douglas", "Fleming", "Jensen", "Vargas", "Byrd", "Davidson", "Hopkins", "May", "Terry", "Herrera", "Wade", "Soto", "Walters", "Curtis", "Neal", "Caldwell", "Lowe", "Jennings", "Barnett", "Graves", "Jimenez", "Horton", "Shelton", "Barrett", "Obrien", "Castro", "Sutton", "Gregory", "Mckinney", "Lucas", "Miles", "Craig", "Rodriquez", "Chambers", "Holt", "Lambert", "Fletcher", "Watts", "Bates", "Hale", "Rhodes", "Pena", "Beck", "Newman"]
MAJOR = ["Undeclared", "African and Afro-American Studies", "American Studies", "Anthropology", "Art History", "Biochemistry", "Biological Physics", "Biology", "Business", "Chemistry", "Classical Studies", "Comparative Literature", "Computer Science", "Creative Writing", "East Asian Studies", "Economics", "Education Studies", "English and American Literature", "Environmental Studies", "European Cultural Studies", "Film, Television, and Interactive Media", "Fine Arts", "French and Francophone Studies", "German Language and Literature", "Health: Science, Society, and Policy", "Hebrew Language and Literature", "Hispanic Studies", "History", "Independent Interdisciplinary", "International and Global Studies", "Islamic and Middle Eastern Studies", "Italian Studies", "Language and Linguistics", "Latin American and Latino Studies", "Music", "Neuroscience", "Philosophy", "Physics", "Psychology", "Russian  Studies", "Sociology", "Studio Art", "Theater Arts", "Women's &and Gender Studies"]
MINOR = ["Undeclared", "African and Afro-American Studies", "Art History", "Business", "Computer Science", "Creative Writing", "East Asian Studies", "Economics", "Education Studies", "English and American Literature", "Environmental Studies", "Film, Television, and Interactive Media", "Fine Arts", "French and Francophone Studies", "German Language and Literature", "Hebrew Language and Literature", "Hispanic Studies", "History", "History of Ideas", "International and Global Studies", "Internet Studies", "Islamic and Middle Eastern Studies", "Italian Studies", "Journalism", "Language and Linguistics", "Latin American and Latino Studies", "Legal Studies", "Mathematics", "Medieval and Renaissance Studies", "Music", "Near Eastern and Judaic Studies", "Peace, Conflict and Coexistence", "Philosophy", "Physics", "Politics", "Religious Studies", "Russian  Studies", "Social Justice and Social Policy", "South Asian Studies", "Teacher Education", "Theater Arts", "Women's and Gender Studies", "Yiddish and East European Jewish Culture"]
YOG = ["2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019", "2020"]
HOW = ["Hiatt NACElink", "Hiatt Emails", "Faculty contact", "Family contact", "Did research and contacted on my own", "Brandeis Staff recommendation", "Brandeis Student recommendation", "Other online resource (Career Search, Idealist.org)", "Hiatt On or off-campus recruiting opportunity", "My current job or internship", "Created the internship on my own", "Career/Internship fair", "Alumni Contact", "Other (please explain)"]
SEMESTER = ["Fall", "Spring", "Summer"]
COMPENSATION = ["None", "Lump Stipend from company", "Hourly Pay", "Weekly Salary", "Parking Costs", "Food Provisions", "Transportation Costs", "Brandeis Internship Funding"]  
INDUSTRY = ["Accounting Services", "Administrative, Technical, Manual, and Professional Services", "Advertising and Marketing/Public Relations/Media Relations", "Agriculture", "Architecture and Urban Planning", "Biotechnology and Pharmaceutical", "Education - Pre-k to 12", "Education - Early Childhood", "Energy/ Utilities / Alternative Energies", "Environment and Conservation", "Finance and Banking", "Fine & Performing Arts", "Food and Beverage", "Foundations", "Government - Federal", "Government - State & Local", "Government - International", "Health Care", "Hospitality (Restaurant, Hotel, Travel)", "Human & Social Services", "Information Technology/Computers", "Insurance", "International", "Law", "Management & Economic Consulting", "Manufacturing", "Media (Broadcast, Print, Digital)", "Military", "Museum, Library, Archives", "Non-Profit", "Publishing and Journalism", "Real Estate", "Religion", "Research", "Retail & Wholesale Trade", "Sports", "Transportation", "Other"]
HOURS = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "25", "30", "35", "40", "40+"]
COUNTRY = ["United States", "Afghanistan", "Albania", "Algeria", "Andorra", "Angola", "Antigua and Barbuda", "Argentina", "Armenia", "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bhutan", "Bolivia", "Bosnia and Herzegovina", "Botswana", "Brazil", "Brunei", "Bulgaria", "Burkina Faso", "Burundi", "Cambodia", "Cameroon", "Canada", "Cape Verde", "Central African Republic", "Chad", "Chile", "China", "Colombi", "Comoros", "Congo (Brazzaville)", "Congo", "Costa Rica", "Cote d'Ivoire", "Croatia", "Cuba", "Cyprus", "Czech Republic", "Denmark", "Djibouti", "Dominica", "Dominican Republic", "East Timor (Timor Timur)", "Ecuador", "Egypt", "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia", "Ethiopia", "Fiji", "Finland", "France", "Gabon", "Gambia, The", "Georgia", "Germany", "Ghana", "Greece", "Grenada", "Guatemala", "Guinea", "Guinea-Bissau", "Guyana", "Haiti", "Honduras", "Hungary", "Iceland", "India", "Indonesia", "Iran", "Iraq", "Ireland", "Israel", "Italy", "Jamaica", "Japan", "Jordan", "Kazakhstan", "Kenya", "Kiribati", "Korea, North", "Korea, South", "Kuwait", "Kyrgyzstan", "Laos", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libya", "Liechtenstein", "Lithuania", "Luxembourg", "Macedonia", "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Marshall Islands", "Mauritania", "Mauritius", "Mexico", "Micronesia", "Moldova", "Monaco", "Mongolia", "Morocco", "Mozambique", "Myanmar", "Namibia", "Nauru", "Nepa", "Netherlands", "New Zealand", "Nicaragua", "Niger", "Nigeria", "Norway", "Oman", "Pakistan", "Palau", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Poland", "Portugal", "Qatar", "Romania", "Russia", "Rwanda", "Saint Kitts and Nevis", "Saint Lucia", "Saint Vincent", "Samoa", "San Marino", "Sao Tome and Principe", "Saudi Arabia", "Senegal", "Serbia and Montenegro", "Seychelles", "Sierra Leone", "Singapore", "Slovakia", "Slovenia", "Solomon Islands", "Somalia", "South Africa", "Spain", "Sri Lanka", "Sudan", "Suriname", "Swaziland", "Sweden", "Switzerland", "Syria", "Taiwan", "Tajikistan", "Tanzania", "Thailand", "Togo", "Tonga", "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan", "Tuvalu", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "Uruguay", "Uzbekistan", "Vanuatu", "Vatican City", "Venezuela", "Vietnam", "Yemen", "Zambia", "Zimbabwe"]
STATE = ['AL', 'AK', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'DC', 'FL', 'GA', 'HI', 'ID', 'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MD', 'MA', 'MI', 'MN', 'MS', 'MO', 'MT', 'NE', 'NV', 'NH', 'NJ', 'NM', 'NY', 'NC', 'ND', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 'VT', 'VA', 'WA', 'WV', 'WI', 'WY']
YEAR = (((Date.today).year - 4)..((Date.today).year + 1)).to_a
BOOLEAN = [true, false]
PERSISTENCE_TOKEN = "07d21add8837fc6548560638e83b17c7bb9f0634a3caf637cec5864acfd9cf88c1fa715adb90a788cb831c76c747dd6010462737fe16f38534c96a40041e7969"
SINGLE_ACCESS_TOKEN = "551u1H9kUUt80TuKaVqW"
PERISHABLE_TOKEN = "NyuQw4yZYZOVsN5DzqVO"
COURSE =["COSI12B", "COSI31A", "MATH140A", "HSSP96A", "UWS32A", "COSI21B", "ENG44A", "HIST78A", "BUS6A", "BUS10A"]
COMPANY_NAME = ["Google", "Microsoft", "Bristol-Myers Squibb", "Apple", "BP", "Brandeis University", "Addidas", "Boston Children's Hospital", "RBS", "PWC"]
COMPANY_DEPARTMENT = ["Human Resources", "Technology", "Marketing", "Information Technology", "Accounting", "Logistics", "Administration", "Communication", "Finance", "Consumer Affairs"]
CITY = ["New York City", "Boston", "Chicago", "Dallas", "Irving", "Seattle", "San Francisco", "Los Angeles", "Houston", "Philadelphia"]
CITY_HASH = {"New York City" => 'NY', "Boston" => 'MA', "Chicago" => 'IL', "Dallas" => 'TX', "Irving" => 'TX', "Seattle" => 'WA', "San Francisco" => 'CA', "Los Angeles" => 'CA', "Houston" => 'TX', "Philadelphia" => 'PA'}
WEBSITE = ["www.google.com", "www.microsoft.com", "www.bms.com", "www.apple.com", "www.bp.com", "www.brandeis.edu", "www.addidas.com", "www.childrenshospital.org", "www.rbs.com", "www.pwc.org"]
SUPERVISION = "The supervision of the company was very relaxed. The supervisor was always there to help and was always interested in my work. Most of the time I would work directly with the supervisor, but it wasn't like they chained a ball to my leg and monitored my every movements. The supervisor overall was very friendly and even took me out to lunch a few times!"
RESPONSIBILITIES = "I had to show up on time, get coffee for people, assist in the given tasks, give weekly presentations on learning outcomes, and be energetic."
RECOMMENDATIONS = "I would really recommend working at this company. They treat all of their interns with respect and integrity. My favorite part of working at this company was the on-hands experience and interaction with professionals. In addition,I have expanded my network by meeting new people, which will ultimately help me in the future."
LIKERT = ["Strongly disagree", "Disagree", "Neither agree nor disagree", "Agree", "Strongly agree"]
count = 0

user_output.puts "murtaza:"
  user_output.puts "  login: murtazajafferji"
  user_output.puts "  name: Murtaza Jafferji"
  user_output.puts "  email: jafferji@brandeis.edu"
  user_output.puts "  crypted_password: 48f18f51e82894ea5c3e0716fdd35ba7bd5986a5ed1c33b66634673a3a7c81aea7b21468175dbf7a1b60600d7cea59235731f3534687ae2e2b3ddcee6feef616"
  user_output.puts "  password_salt: LAS78LUWUfDy9eUWHcRf"
  user_output.puts "  persistence_token: 07d21add8837fc6548560638e83b17c7bb9f0634a3caf637cec5864acfd9cf88c1fa715adb90a788cb831c76c747dd6010462737fe16f38534c96a40041e7969"
  user_output.puts "  single_access_token: 551u1H9kUUt80TuKaVqW"
  user_output.puts "  perishable_token: NyuQw4yZYZOVsN5DzqVO"
  user_output.puts "  major: Computer Science"
  user_output.puts "  minor: Math"
  user_output.puts "  yog: 2012"
  user_output.puts "  first_name: Murtaza"
  user_output.puts "  last_name: Jafferji"

# t.string   "how"
# t.string   "semester"
# t.string   "year"
# t.boolean  "credit"
# t.string   "course"
# t.string   "compensation"
# t.string   "hours"
# t.string   "industry"
# t.string   "company_name"
# t.string   "company_department"
# t.string   "city"
# t.string   "state"
# t.string   "country"
# t.string   "website"
# t.boolean  "public_transport"
# t.text     "supervision"
# t.string   "supervisor_name"
# t.string   "supervisor_phone"
# t.string   "supervisor_email"
# t.text     "responsibilities"
# t.string   "satisfaction_1"
# t.string   "satisfaction_2"
# t.string   "satisfaction_3"
# t.string   "outcome_1"
# t.string   "outcome_2"
# t.string   "outcome_3"
# t.boolean  "offer"
# t.text     "recommendations"

  50.times do
  first_name = FIRST_NAME[rand(300)]
  last_name = LAST_NAME[rand(300)]
  major = MAJOR[rand(44)]
  minor = MINOR[rand(43)]
  yog = YOG[rand(11)]
  
  user_output.puts "#{first_name} #{last_name}:"
  user_output.puts "  email: \"#{first_name.downcase}#{last_name.downcase}@brandeis.edu\""
  user_output.puts "  persistence_token: \"#{PERSISTENCE_TOKEN}\""
  user_output.puts "  single_access_token: \"#{SINGLE_ACCESS_TOKEN}\""
  user_output.puts "  perishable_token: \"#{PERISHABLE_TOKEN}\""
  user_output.puts "  major: \"#{major}\""
  user_output.puts "  minor: \"#{minor}\""
  user_output.puts "  yog: \"#{yog}\""
  user_output.puts "  first_name: \"#{first_name}\""
  user_output.puts "  last_name: \"#{last_name}\""
  
  i = rand(5) + 1
  i.times do
    
  how = HOW[rand(14)]
  semester = SEMESTER[rand(3)]
  year = YEAR[rand(5)]
  credit = BOOLEAN[rand(2)]
  course = COURSE[rand(10)]
  compensation = COMPENSATION[rand(8)]
  hours = HOURS[rand(25)]
  industry = INDUSTRY[rand(38)]
  company_name = COMPANY_NAME[j = rand(10)]
  company_department = COMPANY_DEPARTMENT[rand(10)]
  city = CITY[rand(10)]
  state = CITY_HASH[city]
  #state = STATE[rand(51)]
  #country = COUNTRY[rand(193)]
  country = COUNTRY[0]
  website = WEBSITE[j]
  public_transport = BOOLEAN[rand(2)]
  supervision = SUPERVISION
  supervisor_name = "#{FIRST_NAME[rand(300)]} #{LAST_NAME[rand(300)]}"
  supervisor_phone = "(#{rand.to_s[2..4]}) #{rand.to_s[2..4]}-#{rand.to_s[2..5]}"
  supervisor_email = "#{supervisor_name.gsub(/ /,'').downcase}@gmail.com"
  responsibilities = RESPONSIBILITIES
  satisfaction_1 = LIKERT[rand(5)]
  satisfaction_2 = LIKERT[rand(5)]
  satisfaction_3 = LIKERT[rand(5)]
  outcome_1 = LIKERT[rand(5)]
  outcome_2 = LIKERT[rand(5)]
  outcome_3 = LIKERT[rand(5)]
  offer = BOOLEAN[rand(2)]
  recommendations = RECOMMENDATIONS
  
  internship_output.puts "#{count}:"
  internship_output.puts "  how: \"#{how}\""
  internship_output.puts "  semester: \"#{semester}\""
  internship_output.puts "  year: \"#{year}\""
  internship_output.puts "  credit: #{credit}"
  internship_output.puts "  course: #{course}"
  internship_output.puts "  compensation: #{compensation}"
  internship_output.puts "  hours: #{hours}"
  internship_output.puts "  industry: \"#{industry}\""
  internship_output.puts "  company_name: \"#{company_name}\""
  internship_output.puts "  company_department: \"#{company_department}\""
  internship_output.puts "  city: \"#{city}\""
  internship_output.puts "  state: \"#{state}\""
  internship_output.puts "  country: \"#{country}\""
  internship_output.puts "  website: \"#{website}\""
  internship_output.puts "  public_transport: #{public_transport}"
  internship_output.puts "  supervision: \"#{supervision}\""
  internship_output.puts "  supervisor_name: \"#{supervisor_name}\""
  internship_output.puts "  supervisor_phone: \"#{supervisor_phone}\""
  internship_output.puts "  supervisor_email: \"#{supervisor_email}\""
  internship_output.puts "  responsibilities: \"#{responsibilities}\""
  internship_output.puts "  satisfaction_1: \"#{satisfaction_1}\""
  internship_output.puts "  satisfaction_2: \"#{satisfaction_2}\""
  internship_output.puts "  satisfaction_3: \"#{satisfaction_3}\""
  internship_output.puts "  outcome_1: \"#{outcome_1}\""
  internship_output.puts "  outcome_2: \"#{outcome_2}\""
  internship_output.puts "  outcome_3: \"#{outcome_3}\""
  internship_output.puts "  offer: #{offer}"
  internship_output.puts "  recommendations: \"#{recommendations}\""
  internship_output.puts "  user: \"#{first_name} #{last_name}\""  
  count += 1
  end
end