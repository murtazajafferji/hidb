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
  	  @results = Internship.find(:all, :conditions => ['LOWER(name) LIKE ?', "%#{$query.downcase}%"])
  	        
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
      @autocomplete = Internship.find(:all, :conditions => ['LOWER(name) LIKE ?', "%#{params[:term].downcase}%"], :select => :name, :limit => 5).collect{|x| x.name}
    	
    end

    respond_to do |wants|
      wants.html # index.html.erb
      wants.xml  { render :xml => @autocomplete }
      wants.json { render :json => @autocomplete.to_json }
    end
  end
  
end