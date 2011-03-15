class ItemsController < ApplicationController
  before_filter :require_admin
  # GET /items
  # GET /items.xml
  def index    
    @items = Item.find(:all, :order => "collection, number")
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @items }
      format.csv { send_data @items.to_comma if current_user.admin }
    end
  end

  # GET /items/1
  # GET /items/1.xml
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/new
  # GET /items/new.xml
  def new
    @item = Item.new
    #@user = current_user if current_user

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.xml
  def create
    @item = Item.new(params[:item])
    #@item.user_id = current_user.id

    respond_to do |format|
      if @item.save
        format.html { redirect_to(items_path, :notice => 'Item was successfully created.') }
        format.xml  { render :xml => @item, :status => :created, :location => @item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.xml
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if current_user and @item.update_attributes(params[:item]) #and current_user.super
        format.html { redirect_to(@item, :notice => 'Item was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.xml
  def destroy
    @item = Item.find(params[:id])
    if current_user #and current_user.super
      @item.destroy
    end

    respond_to do |format|
      format.html { redirect_to(items_url) }
      format.xml  { head :ok }
    end
  end
  
  def unapproved    
    @items = Item.find(:all, :conditions => {:approved => false})

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @items }
    end
  end
  
  def approve 
    item = Item.find(params[:item])
    if item.approved == false
      item.approved = true
      if item.save(false)
        flash[:notice] = "You have approved this item"
      else
        flash[:error] = 'Something has gone horribly wrong.'
      end
    else
      item.approved = false
      if item.save(false)
        flash[:notice] = "You have unapproved this item"
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
