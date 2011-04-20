class UsersController < ApplicationController
  before_filter :require_user, :only => [:follow, :unfollow, :edit, :update]
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :admin_only, :only => :detonate

  def index
    @users = User.all
    
    # if params[:term]
    #   #@user_autocomplete = User.find(:all,:conditions => ['name LIKE ? OR login', "%#{params[:term]}%"], :select => "name, login", :limit => 10)
    #   @user_autocomplete = User.find(:all,:conditions => ['LOWER(name) LIKE ? OR LOWER(login) LIKE ?', "%#{params[:term].downcase}%", "%#{params[:term].downcase}%"], :select => "name, login", :limit => 10)
    # end
    
    respond_to do |wants|
      wants.html
      wants.xml  { render :xml => @user_autocomplete }
      wants.json { render :json => @user_autocomplete.to_json }
      wants.csv { send_data @users.to_comma if current_user.admin }
    end
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    # block! see user_sessions_controller.rb for description
    @user.save do |result|
      if result
        flash[:notice] = "Account registered!"
        #redirect_back_or_default profile_url(@user)
        redirect_to edit_user_path(@user)
      else
        flash[:notice] = "Registration failed. Try again."
        redirect_to register_url
      end
    end
  end

  def edit
    @user = @current_user
    @profile = @user.profile
  end
  
  def update
    return create unless @current_user
    @user = @current_user # makes our views "cleaner" and more consistent
    @user.update_attributes(params[:user]) do |result|
      if result
        flash[:notice] = "Account updated!"
        #redirect_to profile_url(@user)
        redirect_to new_internship_path
      else
        raise @user.errors.inspect
        render :action => :edit
      end
    end
  end
 
  def destroy
    @user = User.find_by_url(params[:id])
    if @user.nil?
      @user = User.find(params[:id])
    end
    if current_user and @user.id == current_user.id
      @user.destroy
    end

    respond_to do |wants|
      wants.html { redirect_to(root_path) }
      wants.xml  { head :ok }
    end
  end
  
  def detonate
    session.clear
    User.all.collect(&:destroy)
    redirect_to login_url
  end
  
  def show
    puts "SESSION: #{session.inspect}"
    puts @current_user.access_tokens.inspect if current_user
    @user_size = User.count
    @user = User.find_by_url(params[:id])
    if @user.nil?
      @user = User.find(params[:id])
    end
    @profile = @user.profile
  end

  def activate
    logout_keeping_session!
    user = User.find_by_perishable_token(params[:perishable_token]) unless params[:perishable_token].blank?
    case
    when (!params[:perishable_token].blank?) && user
      user.activate!
      user.activation
      flash[:notice] = "Signup complete! Please sign in to continue."
      redirect_to '/login'
    when params[:perishable_token].blank?
      flash[:error] = "The activation code was missing.  Please follow the URL from your email."
      redirect_back_or_default('/')
    else 
      flash[:error]  = "We couldn't find a user with that activation code -- check your email? Or maybe you've already activated -- try signing in."
      redirect_back_or_default('/')
    end
  end
  
  def change_email
    user = User.find_by_perishable_token(params[:perishable_token]) unless params[:perishable_token].blank?
    case
    when (!params[:perishable_token].blank?) && user
      user.email = user.temp
      user.perishable_token = nil
      user.save(false)
      flash[:notice] = "Email successfully changed!"
      redirect_back_or_default('/')
    when params[:perishable_token].blank?
      flash[:error] = "The token was missing.  Please follow the URL from your email."
      redirect_back_or_default('/')
    else 
      flash[:error]  = "We couldn't find a user with that token -- check your email? Or maybe you've already activated -- try signing in."
      redirect_back_or_default('/')
    end
  end
  
  def follow 
    user =  User.find_by_url(params[:user])
    if current_user.following?(user)
      if current_user.stop_following(user)
        flash[:notice] = "You are no longer following #{user.username}"
      else
        flash[:error] = 'Something has gone horribly wrong.'
      end
    else
      if current_user.follow(user)
        flash[:notice] = "You are now following #{user.username}"
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
  
  def make_admin 
    user = User.find(params[:user])
    if user.admin == false
      user.admin = true
      if user.save(false)
        flash[:notice] = "You have made this user an admin"
      else
        flash[:error] = 'Something has gone horribly wrong.'
      end
    else
      user.admin = false
      if user.save(false)
        flash[:notice] = "You have removed admin access for user"
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
