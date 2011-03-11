class InternshipsController < ApplicationController
  before_filter :require_user, :only => [:create, :update, :destroy]
  before_filter :require_admin, :only => [:unapproved]
  # GET /internships
  # GET /internships.xml
  def index    
    @internships = Internship.sort params
    @internships = @internships.collect{|x| x if x.approved }

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @internships }
      format.csv { send_data Internship.all.to_comma if current_user.admin }
    end
  end

  # GET /internships/1
  # GET /internships/1.xml
  def show
    @internship = Internship.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @internship }
    end
  end

  # GET /internships/new
  # GET /internships/new.xml
  def new
    @internship = Internship.new
    @user = current_user if current_user

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @internship }
    end
  end

  # GET /internships/1/edit
  def edit
    @internship = Internship.find(params[:id])
  end

  # POST /internships
  # POST /internships.xml
  def create
    @internship = Internship.new(params[:internship])
    @internship.user_id = current_user.id

    respond_to do |format|
      if @internship.save
        format.html { redirect_to(internships_path, :notice => 'Internship was successfully created.') }
        format.xml  { render :xml => @internship, :status => :created, :location => @internship }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @internship.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /internships/1
  # PUT /internships/1.xml
  def update
    @internship = Internship.find(params[:id])

    respond_to do |format|
      if current_user and @internship.user_id == current_user.id and @internship.update_attributes(params[:internship])
        format.html { redirect_to(@internship, :notice => 'Internship was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @internship.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /internships/1
  # DELETE /internships/1.xml
  def destroy
    @internship = Internship.find(params[:id])
    if current_user and @internship.user_id == current_user.id
      @internship.destroy
    end

    respond_to do |format|
      format.html { redirect_to(internships_url) }
      format.xml  { head :ok }
    end
  end
  
  def unapproved    
    @internships = Internship.find(:all, :conditions => {:approved => false})

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @internships }
    end
  end
  
  def approve 
    internship = Internship.find(params[:internship])
    if internship.approved == false
      internship.approved = true
      if internship.save(false)
        flash[:notice] = "You have approved this internship"
      else
        flash[:error] = 'Something has gone horribly wrong.'
      end
    else
      internship.approved = false
      if internship.save(false)
        flash[:notice] = "You have unapproved this internship"
      else
        flash[:error] = 'Something has gone horribly wrong.'
      end
    end
    respond_to do |wants|
      wants.html { redirect_to :back }
      wants.xml  { render :xml => @user }
      #wants.js
    end
  end
end
