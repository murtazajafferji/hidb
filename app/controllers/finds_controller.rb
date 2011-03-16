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
          wants.csv { send_data Internship.find_all_by_id(params[:internships]).to_comma if current_user.admin } if params[:internships]
        end
      end
    end
  end
  
  def advanced_search
    text = ["course", "company_name", "company_department", "city"]
    fields = ["how", "semester", "year",  "compensation", "hours", "industry", "state", "country" ]
    boolean = ["credit","public_transport", "offer"]
    @internship = Internship.new
    if params[:internship]
      internship = Internship.new(params[:internship])
      internship.semester = internship.semester.join(" ").strip if internship.semester
      # array = []
      # text_array = []
      # text.each{|x| text_array << "LOWER(x) LIKE '#{eval("internship." + x).downcase}'" if !eval("internship." + x).blank?}
      # array << "\"#{text_array.join(" and ")}\"" if !text_array.blank?
      # fields.each{|x| array << ":#{x} => \"#{eval("internship." + x)}\"" if !eval("internship." + x).blank?}
      # boolean.each{|x| array << ":#{x} => #{eval("internship." + x)}" if !eval("internship." + x).nil?}
      # string = array.join(", ")
      
      first = []
      second = []
      text.each{|x| 
        if !eval("internship." + x).blank?
          first << "LOWER(#{x}) LIKE ?" 
          second << "'%#{eval("internship." + x).downcase}%'"
        end
      }
      fields.each{|x| 
        if !eval("internship." + x).blank?
          first << "#{x} = ?" 
          second << "'#{eval("internship." + x)}'"
        end
      }
      boolean.each{|x| 
        if !eval("internship." + x).nil?
          first << "#{x} = ?" 
          second << "#{eval("internship." + x).to_s}"
        end
      }
      string = "\"#{first.join(" and ")}\", " if !first.blank?
      string += second.join(", ") if !second.blank?
      
    puts "Internship.find(:all, :conditions => [#{string}])"
      if !string.blank?
        @internships = eval("Internship.find(:all, :conditions => [#{string}])")
      end
      
      if !internship.search_string.blank?
        query_set = internship.search_string.downcase.split.to_set
  	    @internships = @internships.collect{|x| x if query_set.subset?(x.search_string.split.to_set)}
  	  end
    end
            

    respond_to do |wants|
      if @internships 
      wants.html #{ redirect_to @internships }
      wants.xml #{ render :xml => @internships }
      wants.js {
        render(:update) {|page| page.replace_html 'results', :partial => 'internships/internship_list', :locals => {:internships => @internships}}
      }  
      wants.csv { send_data @internships.to_comma if current_user.admin }
      else 
      	wants.html 
        wants.xml
        wants.csv { send_data Internship.find_all_by_id(params[:internships]).to_comma if current_user.admin } if params[:internships]
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