class FindsController < ApplicationController
  require 'lib/string.rb'
  
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
  	  @results = Event.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{$query.downcase}%", User.find_by_login("amaltracker")])
  	  @results += Event.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{$query.downcase}%", current_user]) if current_user
  	  @results += Person.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{$query.downcase}%", User.find_by_login("amaltracker")])
  	  @results += Person.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{$query.downcase}%", current_user]) if current_user
  	  @results += Namaz.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{$query.downcase}%", User.find_by_login("amaltracker")])
  	  @results += Namaz.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{$query.downcase}%", current_user]) if current_user
  	  @results += Tasbih.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{$query.downcase}%", User.find_by_login("amaltracker")])
  	  @results += Tasbih.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{$query.downcase}%", current_user]) if current_user
  	  @results += Exercise.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{$query.downcase}%", User.find_by_login("amaltracker")])
  	  @results += Exercise.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{$query.downcase}%", current_user]) if current_user
  	  @results += Task.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{$query.downcase}%", User.find_by_login("amaltracker")])
  	  @results += Task.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{$query.downcase}%", current_user]) if current_user
  	  @results += Homework.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{$query.downcase}%", User.find_by_login("amaltracker")])
  	  @results += Homework.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{$query.downcase}%", current_user]) if current_user
  	  @results += Quran.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{$query.downcase}%", User.find_by_login("amaltracker")])
  	  @results += Quran.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{$query.downcase}%", current_user]) if current_user
  	  @results += Dua.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{$query.downcase}%", User.find_by_login("amaltracker")])
  	  @results += Dua.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{$query.downcase}%", current_user]) if current_user
  	  @results += Roza.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{$query.downcase}%", User.find_by_login("amaltracker")])
  	  @results += Roza.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{$query.downcase}%", current_user]) if current_user
  	  @results += Ziyarat.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{$query.downcase}%", User.find_by_login("amaltracker")])
  	  @results += Ziyarat.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{$query.downcase}%", current_user]) if current_user
  	  @results += Hifz.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{$query.downcase}%", User.find_by_login("amaltracker")])
  	  @results += Hifz.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{$query.downcase}%", current_user]) if current_user
  	  @results += Expense.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{$query.downcase}%", User.find_by_login("amaltracker")])
    	@results += Expense.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{$query.downcase}%", current_user]) if current_user
  	        
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
  
  def quran_search
    if params[:sipara]
      @qurans = Quran.sipara(params[:sipara].to_i)
      @name = @qurans[0].sipara_name if !@qurans.blank?
    end
    
    if params[:surat]
      @qurans = Quran.surat(params[:surat].to_i)
      @name = "Surat: #{@qurans[0].surat_name_arabic}</p>" if !@qurans.blank?
    end
    
    if params[:ayat]
      ayat = params[:ayat].gsub(/[^0-9\-:]/, "").split(':')
      if ayat[1].include? "-"
        ayat = ayat[0].to_a + ayat[1].split("-")
        @qurans = Quran.find(:all, :order => :ayat, :conditions => {:surat => ayat[0].to_i, :ayat => (ayat[1].to_i..ayat[2].to_i).to_a, :kind => :ayat}).to_a
        @name = "#{@qurans[0].name} - #{@qurans.last.name} #{@qurans[0].surat_name_arabic}</p>" if !@qurans.blank?
      else
        @qurans = Quran.find(:first, :conditions => {:surat => ayat[0].to_i, :ayat => ayat[1].to_i, :kind => :ayat}).to_a
        @name = "#{@qurans[0].name} #{@qurans[0].surat_name_arabic}</p>" if !@qurans.blank?
      end
    end
    
    respond_to do |wants|
      wants.html { redirect_to @qurans }
      wants.xml { render :xml => @qurans }
      wants.js {
        render(:update) {|page| page.replace_html 'quran_search', :partial => 'qurans/quran_search', :locals => {:qurans => @qurans, :name => @name}}
      }    
    end
  end
        
  
  def autocomplete
    if params[:term]
      @autocomplete = Event.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{params[:term].downcase}%", User.find_by_login("amaltracker")], :select => :name, :limit => 5).collect{|x| x.name}
      @autocomplete += Event.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{params[:term].downcase}%", current_user], :select => :name, :limit => 5).collect{|x| x.name} if current_user
    	@autocomplete += Person.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{params[:term].downcase}%", User.find_by_login("amaltracker")], :select => :name, :limit => 5).collect{|x| x.name}
    	@autocomplete += Person.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{params[:term].downcase}%", current_user], :select => :name, :limit => 5).collect{|x| x.name} if current_user
    	@autocomplete += Namaz.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{params[:term].downcase}%", User.find_by_login("amaltracker")], :select => :name, :limit => 5).collect{|x| x.name.capitalizer}
    	@autocomplete += Namaz.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{params[:term].downcase}%", current_user], :select => :name, :limit => 5).collect{|x| x.name.capitalizer} if current_user
    	@autocomplete += Tasbih.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{params[:term].downcase}%", User.find_by_login("amaltracker")], :select => :name, :limit => 5).collect{|x| x.name}
    	@autocomplete += Tasbih.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{params[:term].downcase}%", current_user], :select => :name, :limit => 5).collect{|x| x.name} if current_user
    	@autocomplete += Exercise.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{params[:term].downcase}%", User.find_by_login("amaltracker")], :select => :name, :limit => 5).collect{|x| x.name}
    	@autocomplete += Exercise.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{params[:term].downcase}%", current_user], :select => :name, :limit => 5).collect{|x| x.name} if current_user
    	@autocomplete += Task.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{params[:term].downcase}%", User.find_by_login("amaltracker")], :select => :name, :limit => 5).collect{|x| x.name}
    	@autocomplete += Task.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{params[:term].downcase}%", current_user], :select => :name, :limit => 5).collect{|x| x.name} if current_user
    	@autocomplete += Homework.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{params[:term].downcase}%", User.find_by_login("amaltracker")], :select => :name, :limit => 5).collect{|x| x.name}
    	@autocomplete += Homework.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{params[:term].downcase}%", current_user], :select => :name, :limit => 5).collect{|x| x.name} if current_user
    	@autocomplete += Quran.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{params[:term].downcase}%", User.find_by_login("amaltracker")], :select => :name, :limit => 5).collect{|x| x.name}
    	@autocomplete += Quran.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{params[:term].downcase}%", current_user], :select => :name, :limit => 5).collect{|x| x.name} if current_user
    	@autocomplete += Dua.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{params[:term].downcase}%", User.find_by_login("amaltracker")], :select => :name, :limit => 5).collect{|x| x.name}
    	@autocomplete += Dua.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{params[:term].downcase}%", current_user], :select => :name, :limit => 5).collect{|x| x.name} if current_user
    	@autocomplete += Roza.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{params[:term].downcase}%", User.find_by_login("amaltracker")], :select => :name, :limit => 5).collect{|x| x.name}
    	@autocomplete += Roza.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{params[:term].downcase}%", current_user], :select => :name, :limit => 5).collect{|x| x.name} if current_user
    	@autocomplete += Ziyarat.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{params[:term].downcase}%", User.find_by_login("amaltracker")], :select => :name, :limit => 5).collect{|x| x.name}
    	@autocomplete += Ziyarat.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{params[:term].downcase}%", current_user], :select => :name, :limit => 5).collect{|x| x.name} if current_user
    	@autocomplete += Hifz.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{params[:term].downcase}%", User.find_by_login("amaltracker")], :select => :name, :limit => 5).collect{|x| x.name}
    	@autocomplete += Hifz.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{params[:term].downcase}%", current_user], :select => :name, :limit => 5).collect{|x| x.name} if current_user
    	@autocomplete += Expense.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{params[:term].downcase}%", User.find_by_login("amaltracker")], :select => :name, :limit => 5).collect{|x| x.name}
      @autocomplete += Expense.find(:all, :conditions => ['LOWER(name) LIKE ? and user_id = ?', "%#{params[:term].downcase}%", current_user], :select => :name, :limit => 5).collect{|x| x.name} if current_user
    	
    end

    respond_to do |wants|
      wants.html # index.html.erb
      wants.xml  { render :xml => @autocomplete }
      wants.json { render :json => @autocomplete.to_json }
    end
  end
  
end