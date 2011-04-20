class User < ActiveRecord::Base
  has_many :internships
  
  #validates_format_of :yog, :with => /\d\d\d\d/, :if => :yog?
  
  acts_as_voter
  has_karma :internships
  
  validates_uniqueness_of :username
  
  acts_as_authentic do |config|
    config.validate_email_field    = false
    config.validate_login_field    = false
    config.validate_password_field = false
    config.login_field = 'email'
  end  
  
  comma do
    login
    email
    login_count
    url
    username
    linkedin
    admin
    first_name
    last_name
    major
    yog
    created_at
    updated_at
  end
    
  include Profile
  
  #before_create :make_slug
  
  after_create :signup_notification
  # before_update :email_changed_notification
  
  before_create :make_activation_code
  
  after_save :make_search_string

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :password, :password_confirmation, :url, :preference, :first_name, :last_name, :major, :yog, :admin, :username, :linkedin
  
  preference :comment_notification, :default => true
  
  # MAJOR = 
  #   ["Undeclared",
  # "African and Afro-American Studies",
  # "American Studies",
  # "Anthropology",
  # "Art History",
  # "Biochemistry",
  # "Biological Physics",
  # "Biology",
  # "Business",
  # "Chemistry",
  # "Classical Studies",
  # "Comparative Literature",
  # "Computer Science",
  # "Creative Writing",
  # "East Asian Studies",
  # "Economics",
  # "Education Studies",
  # "English and American Literature",
  # "Environmental Studies",
  # "European Cultural Studies",
  # "Film, Television, and Interactive Media",
  # "Fine Arts",
  # "French and Francophone Studies",
  # "German Language and Literature",
  # "Health: Science, Society, and Policy",
  # "Hebrew Language and Literature",
  # "Hispanic Studies",
  # "History",
  # "Independent Interdisciplinary",
  # "International and Global Studies",
  # "Islamic and Middle Eastern Studies",
  # "Italian Studies",
  # "Language and Linguistics",
  # "Latin American and Latino Studies",
  # "Music",
  # "Neuroscience",
  # "Philosophy",
  # "Physics",
  # "Psychology",
  # "Russian  Studies",
  # "Sociology",
  # "Studio Art",
  # "Theater Arts",
  # "Women's &and Gender Studies"]
  
MAJOR = ["Agricultural Sciences", "Anthropology", "Architecture and Environmental Design", "Art and Design", "Biological Sciences", "Business and Economics", "Chemistry", "Communications", "Computer Science", "Culture and Society", "Engineering", "Environmental Studies and Sciences", "Health and Physical Education", "History", "Humanities", "Languages and Literature", "Mathematics", "Media/Film and Television ", "Performing Arts ", "Philosophy", "Physical Sciences", "Physics", "Political Science ", "Psychology", "Sociology and Social Sciences", "Teacher Education", "Undeclared"]

  YOG = [
    "2010",
    "2011",
    "2012",
    "2013",
    "2014",
    "2015",
    "2016",
    "2017",
    "2018",
    "2019",
    "2020"]
    
  def make_search_string
    internships.each{|x| x.make_search_string}
  end
  
  def required
    #!email.blank? and !major.blank? and !yog.blank? and !first_name.blank? and !last_name.blank?
    !username.blank?
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end
  
  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end
  
  # def username
  #   if !name.nil? and name != ""
  #     name
  #   else
  #     login
  #   end
  # end
  
  def make_slug
    self.url = self.login.to_url
  end
  
  def to_param
    if url
      url
    else
      id.to_s
    end
  end
  
  #new_facebooker.activate!
  
  # Activates the user in the database.
  def activate!
    self.activated_at = Time.now.utc
    self.perishable_token = nil
    save(false)
  end

  def signup_notification
    if !email.blank?
      setup_email
      @subject     = "Confirm your #{SITE_NAME} account, #{username}!"
      @body        = "Your #{SITE_NAME} account has been created!<br><br>

      Username: #{login}<br><br>

      Confirm your account by clicking on this link:<br>
      #{SITE_URL}/activate/#{perishable_token}"
  
      Pony.mail(
        :subject => @subject, 
        :html_body => @body
      )
    end
  end

  def activation
    setup_email
    @subject     = "Welcome to #{SITE_NAME}, #{username}!"
    @body        = "#{username}, your account has been activated.  Welcome aboard!<br><br>

    #{SITE_URL}"
  
    Pony.mail(
      :subject => @subject, 
      :html_body => @body
    )
  end
  
  # def comment_notification
  #   if prefers?(:comment_notification) 
  #     write_preference(:comment_notification, false)
  #   else
  #     write_preference(:comment_notification, true)
  #   end
  #   save(false)
  #   prefers?(:comment_notification) 
  # end

  def email_changed_notification
    if self.email_changed? and (self.email != self.temp)
      self.perishable_token = make_token
      setup_email
      @subject     = "Email address verification"
      @body        = "Please click this link to verify this email address: \n#{SITE_URL}/change/#{perishable_token}"
  
      Pony.mail(
        :subject => @subject, 
        :body => @body
      )
      self.temp = self.email
      self.email = self.email_was
    end
  end
  
  protected
    require 'digest/sha1'
    def secure_digest(*args)
      Digest::SHA1.hexdigest(args.flatten.join('--'))
    end
    
    def make_token
      secure_digest(Time.now, (1..10).map{ rand.to_s })
    end
    
    def make_activation_code
      self.perishable_token = make_token
    end
    
    def setup_email
      Pony.options = {
        :from => "#{SITE_NAME} <#{SITE_EMAIL}>", 
        :to => email, 
        :via => :smtp, 
        :via_options => {
          :address              => 'smtp.gmail.com',
          :port                 => '587',
          :enable_starttls_auto => true,
          :user_name            => SITE_EMAIL,
          :password             => 'temporary',
          :authentication       => :plain # :plain, :login, :cram_md5, no auth by default
          #:domain               => "localhost.localdomain" # the HELO domain provided by the client to the server
        } 
      }
    end
  
end
