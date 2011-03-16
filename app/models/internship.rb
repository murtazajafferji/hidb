class Internship < ActiveRecord::Base
  belongs_to :user
  after_save :make_search_string
  
  comma do
    user :login
    user :email
    user :login_count
    user :url
    user :name
    user :admin
    user :super
    user :first_name
    user :last_name
    user :major
    user :minor
    user :yog
    user :created_at
    user :updated_at
    how
    semester
    year
    credit
    course
    compensation
    hours
    industry
    company_name
    company_department
    city
    state
    country
    website
    public_transport
    supervision
    supervisor_name
    supervisor_phone
    supervisor_email
    responsibilities
    satisfaction_1
    satisfaction_2
    satisfaction_3
    outcome_1
    outcome_2
    outcome_3
    offer
    recommendations
    approved
    user_id
    created_at
    updated_at
  end


    HOW = [
    "Hiatt NACElink",
    "Hiatt Emails",
    "Faculty contact",
    "Family contact",
    "Did research and contacted on my own",
    "Brandeis Staff recommendation",
    "Brandeis Student recommendation",
    "Other online resource (Career Search, Idealist.org)",
    "Hiatt On or off-campus recruiting opportunity",
    "My current job or internship",
    "Created the internship on my own",
    "Career/Internship fair",
    "Alumni Contact",
    "Other (please explain)"]
    
    SEMESTER =
    ["Fall",
      "Spring",
      "Summer"
    ]
    
    COMPENSATION = [
      "None",
      "Lump Stipend from company",
      "Hourly Pay",
      "Weekly Salary",
      "Parking Costs",
      "Food Provisions",
      "Transportation Costs",
      "Brandeis Internship Funding"]
      
    INDUSTRY = [
      "Accounting Services",
      "Administrative, Technical, Manual, and Professional Services",
      "Advertising and Marketing/Public Relations/Media Relations",
      "Agriculture",
      "Architecture and Urban Planning",
      "Biotechnology and Pharmaceutical",
      "Education - Pre-k to 12",
      "Education - Early Childhood",
      "Energy/ Utilities / Alternative Energies",
      "Environment and Conservation",
      "Finance and Banking",
      "Fine & Performing Arts",
      "Food and Beverage",
      "Foundations",
      "Government - Federal",
      "Government - State & Local",
      "Government - International",
      "Health Care",
      "Hospitality (Restaurant, Hotel, Travel)",
      "Human & Social Services",
      "Information Technology/Computers",
      "Insurance",
      "International",
      "Law",
      "Management & Economic Consulting",
      "Manufacturing",
      "Media (Broadcast, Print, Digital)",
      "Military",
      "Museum, Library, Archives",
      "Non-Profit",
      "Publishing and Journalism",
      "Real Estate",
      "Religion",
      "Research",
      "Retail & Wholesale Trade",
      "Sports",
      "Transportation",
      "Other"]
      
      HOURS = 
      ["1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "10",
      "11",
      "12",
      "13",
      "14",
      "15",
      "16",
      "17",
      "18",
      "19",
      "20",
      "25",
      "30",
      "35",
      "40",
      "40+"]
      
      COUNTRY =[ 
       "United States", 
       "Afghanistan",
      		"Albania",
      		"Algeria",
      		"Andorra",
      		"Angola",
      		"Antigua and Barbuda",
      		"Argentina",
      		"Armenia",
      		"Australia",
      		"Austria",
      		"Azerbaijan",
      		"Bahamas",
      		"Bahrain",
      		"Bangladesh",
      		"Barbados",
      		"Belarus",
      		"Belgium",
      		"Belize",
      		"Benin",
      		"Bhutan",
      		"Bolivia",
      		"Bosnia and Herzegovina",
      		"Botswana",
      		"Brazil",
      		"Brunei",
      		"Bulgaria",
      		"Burkina Faso",
      		"Burundi",
      		"Cambodia",
      		"Cameroon",
      		"Canada",
      		"Cape Verde",
      		"Central African Republic",
      		"Chad",
      		"Chile",
      		"China",
      		"Colombi",
      		"Comoros",
      		"Congo (Brazzaville)",
      		"Congo",
      		"Costa Rica",
      		"Cote d'Ivoire",
      		"Croatia",
      		"Cuba",
      		"Cyprus",
      		"Czech Republic",
      		"Denmark",
      		"Djibouti",
      		"Dominica",
      		"Dominican Republic",
      		"East Timor (Timor Timur)",
      		"Ecuador",
      		"Egypt",
      		"El Salvador",
      		"Equatorial Guinea",
      		"Eritrea",
      		"Estonia",
      		"Ethiopia",
      		"Fiji",
      		"Finland",
      		"France",
      		"Gabon",
      		"Gambia, The",
      		"Georgia",
      		"Germany",
      		"Ghana",
      		"Greece",
      		"Grenada",
      		"Guatemala",
      		"Guinea",
      		"Guinea-Bissau",
      		"Guyana",
      		"Haiti",
      		"Honduras",
      		"Hungary",
      		"Iceland",
      		"India",
      		"Indonesia",
      		"Iran",
      		"Iraq",
      		"Ireland",
      		"Israel",
      		"Italy",
      		"Jamaica",
      		"Japan",
      		"Jordan",
      		"Kazakhstan",
      		"Kenya",
      		"Kiribati",
      		"Korea, North",
      		"Korea, South",
      		"Kuwait",
      		"Kyrgyzstan",
      		"Laos",
      		"Latvia",
      		"Lebanon",
      		"Lesotho",
      		"Liberia",
      		"Libya",
      		"Liechtenstein",
      		"Lithuania",
      		"Luxembourg",
      		"Macedonia",
      		"Madagascar",
      		"Malawi",
      		"Malaysia",
      		"Maldives",
      		"Mali",
      		"Malta",
      		"Marshall Islands",
      		"Mauritania",
      		"Mauritius",
      		"Mexico",
      		"Micronesia",
      		"Moldova",
      		"Monaco",
      		"Mongolia",
      		"Morocco",
      		"Mozambique",
      		"Myanmar",
      		"Namibia",
      		"Nauru",
      		"Nepa",
      		"Netherlands",
      		"New Zealand",
      		"Nicaragua",
      		"Niger",
      		"Nigeria",
      		"Norway",
      		"Oman",
      		"Pakistan",
      		"Palau",
      		"Panama",
      		"Papua New Guinea",
      		"Paraguay",
      		"Peru",
      		"Philippines",
      		"Poland",
      		"Portugal",
      		"Qatar",
      		"Romania",
      		"Russia",
      		"Rwanda",
      		"Saint Kitts and Nevis",
      		"Saint Lucia",
      		"Saint Vincent",
      		"Samoa",
      		"San Marino",
      		"Sao Tome and Principe",
      		"Saudi Arabia",
      		"Senegal",
      		"Serbia and Montenegro",
      		"Seychelles",
      		"Sierra Leone",
      		"Singapore",
      		"Slovakia",
      		"Slovenia",
      		"Solomon Islands",
      		"Somalia",
      		"South Africa",
      		"Spain",
      		"Sri Lanka",
      		"Sudan",
      		"Suriname",
      		"Swaziland",
      		"Sweden",
      		"Switzerland",
      		"Syria",
      		"Taiwan",
      		"Tajikistan",
      		"Tanzania",
      		"Thailand",
      		"Togo",
      		"Tonga",
      		"Trinidad and Tobago",
      		"Tunisia",
      		"Turkey",
      		"Turkmenistan",
      		"Tuvalu",
      		"Uganda",
      		"Ukraine",
      		"United Arab Emirates",
      		"United Kingdom",
      		"Uruguay",
      		"Uzbekistan",
      		"Vanuatu",
      		"Vatican City",
      		"Venezuela",
      		"Vietnam",
      		"Yemen",
      		"Zambia",
      		"Zimbabwe"]
      		
      		STATE = ['AL',
                          'AK', 
                          'AZ', 
                          'AR', 
                          'CA', 
                          'CO', 
                          'CT', 
                          'DE', 
                          'DC', 
                          'FL', 
                          'GA', 
                          'HI', 
                          'ID', 
                          'IL', 
                          'IN', 
                          'IA', 
                          'KS', 
                          'KY', 
                          'LA', 
                          'ME', 
                          'MD', 
                          'MA', 
                          'MI', 
                          'MN', 
                          'MS', 
                          'MO', 
                          'MT',
                          'NE',
                          'NV',
                          'NH',
                          'NJ',
                          'NM',
                          'NY',
                          'NC',
                          'ND',
                          'OH', 
                          'OK', 
                          'OR', 
                          'PA', 
                          'RI', 
                          'SC', 
                          'SD',
                          'TN', 
                          'TX', 
                          'UT', 
                          'VT', 
                          'VA', 
                          'WA', 
                          'WV', 
                          'WI', 
                          'WY']
  YEAR = (((Date.today - 4.years).year)..((Date.today + 1.year).year)).to_a
  
  LIKERT = ["Strongly disagree", "Disagree", "Agree", "Strongly agree"]
  PAGE_LIMIT = 100
  
  def self.sort params = {}
    
    # Initialize empty query parts
    select = ""
    order = ""
    where = ""
    if params[:sort]
      sort = params[:sort]
      
      order = "#{sort} ASC"
              
      # Otherwise, check if the sorting parameter is the string date
    else
      order = "created_at DESC"
        #raise "invalid :sort parameter for Internship.list"     
    end # params[:sort]
    
    
    # Limit the query to 100 results
    query_params = {:limit => PAGE_LIMIT}
    
    # Set the other query parameters
    if !select.empty? then query_params[:select] = select end
    if !order.empty? then query_params[:order] = order end
    if !where.empty? then query_params[:conditions] = where end
    if params[:page]
      query_params[:offset] = (params[:page] - 1) * PAGE_LIMIT
    end
    
    # Execute the query
    self.all(query_params)
  end
  
  def make_search_string
    internship_fields = ["semester", "year", "course", "hours", "industry", "company_name", "company_department", "city", "state", "country", "website", "user_id"]
    user_fields = ["user.first_name", "user.last_name", "user.email", "user.major", "user.minor"]
    string = []
    (internship_fields + user_fields).each{|x| string << eval(x).to_s.downcase if !eval(x).blank?}
    string = string.join(" ")
    if self.search_string != string
      self.search_string = string
      save
    end
  end

      
end
