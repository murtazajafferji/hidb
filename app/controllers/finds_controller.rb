class FindsController < ApplicationController
  require 'lib/string.rb'
  before_filter :require_user, :only => [:index]
  
  def index
    if params[:user]
  	  $query = params[:user].lstrip.rstrip
  	  @result = User.find(:first, :conditions => ['LOWER(name) LIKE ?', "#{$query.downcase}%"])
  	  if @result.nil?
  	  	@result = User.find(:first, :conditions => ['LOWER(login) LIKE ?', "#{$query.downcase}%"])
  	  end
  	end
  	
  	if params[:word]
  	  $query = params[:word].lstrip.rstrip
  	  query_set = $query.downcase.split.to_set
  	  @results = Internship.all.collect{|x| x if query_set.subset?(x.search_string.split.to_set)}
  	  #@results = Internship.find(:all, :conditions => ['LOWER(semester) LIKE ? or LOWER(year) LIKE ? or LOWER(course) LIKE ? or LOWER(industry) LIKE ? or LOWER(company_name) LIKE ? or LOWER(company_department) LIKE ? or LOWER(city) LIKE ? or LOWER(state) LIKE ? or LOWER(country) LIKE ?', "%#{$query.downcase}%", "%#{$query.downcase}%", "%#{$query.downcase}%", "%#{$query.downcase}%", "%#{$query.downcase}%", "%#{$query.downcase}%", "%#{$query.downcase}%", "%#{$query.downcase}%", "%#{$query.downcase}%"]).to_a
  	  #@results += User.find(:all, :conditions => ['LOWER(email) LIKE ? or LOWER(first_name) LIKE ? or LOWER(last_name) LIKE ? or LOWER(major) LIKE ? or LOWER(minor) LIKE ? or LOWER(yog) LIKE ?', "%#{$query.downcase}%", "%#{$query.downcase}%", "%#{$query.downcase}%", "%#{$query.downcase}%", "%#{$query.downcase}%", "%#{$query.downcase}%"]).to_a
  	        
  	  @result = @results.size == 1? @results.first : nil
    end
    
    if $query == "↑, ↑, ↓, ↓, ←, →, ←, →, B, A, ENTER" or $query == "(↑, ↑, ↓, ↓, ←, →, ←, →, B, A, ENTER)"
    	redirect_to konami_path
    else
      respond_to do |wants|
        if @result 
          wants.html { redirect_to @result }
          wants.xml  { render :xml => @result }
          wants.json { render :json => @result }
        else 
        	wants.html 
          wants.xml
        end
      end
    end
  end
  
  def advanced_search
    fields = ["how", "semester", "year",  "course", "compensation", "hours", "industry", "company_name", "company_department", "city", "state", "country" ]
    boolean = ["credit","public_transport", "offer"]
    @internship = Internship.new
    if params[:internship]
      internship = Internship.new(params[:internship])
      internship.semester = internship.semester.join(" ").strip if internship.semester
      array = []
      fields.each{|x| array << ":#{x} => \"#{eval("internship." + x)}\"" if !eval("internship." + x).blank?}
      boolean.each{|x| array << ":#{x} => #{eval("internship." + x)}" if !eval("internship." + x).blank?}
      string = array.join(", ")
      if !string.blank?
        @internships = eval("Internship.find(:all, :conditions => {#{string}})")
      end
    end
        
    # if advanced_search[:year]
    #   @internships = Internship.all
    # end
            

    respond_to do |wants|
      if @internships 
      wants.html #{ redirect_to @internships }
      wants.xml #{ render :xml => @internships }
      wants.js {
        render(:update) {|page| page.replace_html 'results', :partial => 'internships/internship_list', :locals => {:internships => @internships}}
      }    
      else 
      	wants.html 
        wants.xml
      end
    end
  end
        
  
  def autocomplete
    if params[:term]
      @autocomplete = Internship.find(:all, :conditions => ['LOWER(name) LIKE ?', "%#{params[:term].downcase}%"], :select => :name, :limit => 5).collect{|x| x.name}
    	
    end

    respond_to do |wants|
      wants.html # index.html.erb
      wants.xml  { render :xml => @autocomplete }
      wants.json { render :json => @autocomplete.to_json }
    end
  end
  
end