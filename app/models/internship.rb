class Internship < ActiveRecord::Base  
  belongs_to :user
  after_save :make_search_string
  
  validates_presence_of :company_name, :description, :semester, :year, :job_field, :paid, :full_time#, :past, :available

  acts_as_voteable
  
  comma do
    user :login
    user :email
    user :login_count
    user :url
    user :username
    user :admin
    user :first_name
    user :last_name
    user :major
    user :yog
    user :created_at
    user :updated_at
    semester
    year
    industry
    company_name
    job_field
    city
    state
    country
    website
    responsibilities
    review
    #approved
    user_id
    created_at
    updated_at
  end

  #JOB_FIELD = ["Accounting and Auditing", "Administrative", "Advertising and Marketing", "Advocacy", "Analyst", "Consultant", "Counseling", "Customer Service", "Design", "Educator/Instructor", "Engineering", "Event Planning", "Fundraising and Development", "Health Care Practitioner", "Human Resources and Recruiting", "Information Technology", "Legal Practitioner", "Management", "Other", "Performer/Artist", "Project Management", "Research ", "Sales", "Writer/Editor"]
  JOB_FIELD = ["Accounting, Finance, and Insurance ", "Administrative and Clerical ", "Banking, Real Estate, and Mortgage Professionals", "Biotech, R&D, and Science ", "Building Construction and Skilled Trades ", "Business and Strategic Management ", "Creative and Design ", "Customer Support and Client Care ", "Editorial and Writing ", "Education and Training ", "Engineering ", "Food Services and Hospitality ", "Human Resources ", "Installation, Maintenance, and Repair ", "IT and Software Development ", "Legal ", "Logistics and Transportation ", "Manufacturing, Production, and Operations", "Marketing and Product ", "Medical and Health ", "Other ", "Project and Program Management ", "Quality Assurance and Safety ", "Sales, Retail, and Business Development ", "Security and Protective Services "]
  
  #INDUSTRY = ["Administrative, Technical, Manual, and Professional Services", "Advertising and Marketing, and Public Relations", "Agriculture", "Architecture and Urban Planning", "Biotech/Pharmaceutical", "Education K-12", "Education, Early Childhood", "Energy, Utilities, and Alternative Energy", "Environment and Conservation", "Finance and Banking", "Fine and Performing Arts", "Food and Beverage", "Foundations", "Government", "Government -  International", "Government - Federal", "Government - State, Local", "Healthcare", "Higher Education", "Hospitality (Restaurant, Hotel, Travel, Recreation)", "Human and Social Services", "Information Technology/Computers", "Insurance", "International", "Law", "Management and Economic Consulting", "Manufacturing", "Media (Broadcast, Print, Digital)", "Military", "Museum, Library, Archives", "Other", "Public and Media Relations", "Publishing", "Real Estate", "Religion", "Retail and Wholesale Trade", "Sports", "Transportation Services"]
  INDUSTRY = ["Accounting and Auditing Services ", "Advertising and PR Services ", "Aerospace and Defense ", "Agriculture, Forestry, and Fishing ", "Architectural and Design Services ", "Automotive and Parts Manufacturing ", "Automotive Sales and Repair Services ", "Banking ", "Biotechnology and Pharmaceuticals ", "Broadcasting, Music, and Film ", "Business Services - Other ", "Chemicals and Petro-Chemicals ", "Clothing and Textile Manufacturing ", "Computer Hardware ", "Computer Software ", "Computer and IT Services ", "Construction - Industrial Facilities and Infrastructure ", "Construction - Residential & Commercial and Office ", "Consumer Packaged Goods Manufacturing ", "Education ", "Electronics, Components, and Semiconductor Manufacturing ", "Energy and Utilities ", "Engineering Services ", "Entertainment Venues and Theaters ", "Financial Services ", "Food and Beverage Production ", "Government and Military ", "Healthcare Services ", "Hotels and Lodging ", "Insurance ", "Internet Services ", "Legal Services ", "Management Consulting Services ", "Manufacturing - Other ", "Marine Manufacturing & Services ", "Medical Devices and Supplies ", "Metals and Minerals ", "Nonprofit Charitable Organizations ", "Other and Not Classified ", "Performing and Fine Arts ", "Personal and Household Services ", "Printing and Publishing ", "Real Estate and Property Management ", "Rental Services ", "Restaurant and Food Services ", "Retail ", "Security and Surveillance ", "Sports and Physical Recreation ", "Staffing and Employment Agencies ", "Telecommunications Services ", "Transport and Storage - Materials ", "Travel, Transportation and Tourism ", "Waste Management ", "Wholesale Trade and Import-Export "]
  
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
      "Transportation Costs"]
      
    # INDUSTRY = [
    #   "Accounting Services",
    #   "Administrative, Technical, Manual, and Professional Services",
    #   "Advertising and Marketing/Public Relations/Media Relations",
    #   "Agriculture",
    #   "Architecture and Urban Planning",
    #   "Biotechnology and Pharmaceutical",
    #   "Education - Pre-k to 12",
    #   "Education - Early Childhood",
    #   "Energy/ Utilities / Alternative Energies",
    #   "Environment and Conservation",
    #   "Finance and Banking",
    #   "Fine & Performing Arts",
    #   "Food and Beverage",
    #   "Foundations",
    #   "Government - Federal",
    #   "Government - State & Local",
    #   "Government - International",
    #   "Health Care",
    #   "Hospitality (Restaurant, Hotel, Travel)",
    #   "Human & Social Services",
    #   "Information Technology/Computers",
    #   "Insurance",
    #   "International",
    #   "Law",
    #   "Management & Economic Consulting",
    #   "Manufacturing",
    #   "Media (Broadcast, Print, Digital)",
    #   "Military",
    #   "Museum, Library, Archives",
    #   "Non-Profit",
    #   "Publishing and Journalism",
    #   "Real Estate",
    #   "Religion",
    #   "Research",
    #   "Retail & Wholesale Trade",
    #   "Sports",
    #   "Transportation",
    #   "Other"]
      
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
    internship_fields = ["semester", "year", "industry", "company_name", "job_field", "city", "state", "country", "website", "user_id"]
    user_fields = ["user.first_name", "user.last_name", "user.email", "user.major", "user.username"]
    string = []
    (internship_fields + user_fields).each{|x| string << eval(x).to_s.downcase if !eval(x).blank?}
    string = string.join(" ")
    if self.search_string != string
      self.search_string = string
      save
    end
  end

      
end
