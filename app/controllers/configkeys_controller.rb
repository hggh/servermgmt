class ConfigkeysController < ApplicationController
  # GET /configkeys
  # GET /configkeys.xml
  def index
    @configkeys = Configkey.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @configkeys }
    end
  end

  # GET /configkeys/1
  # GET /configkeys/1.xml
  def show
    @configkey = Configkey.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @configkey }
    end
  end

  # GET /configkeys/new
  # GET /configkeys/new.xml
  def new
    @configkey = Configkey.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @configkey }
    end
  end

  # GET /configkeys/1/edit
  def edit
    @configkey = Configkey.find(params[:id])
  end

  # POST /configkeys
  # POST /configkeys.xml
  def create
    @configkey = Configkey.new(params[:configkey])

    respond_to do |format|
      if @configkey.save
        flash[:notice] = 'Configkey was successfully created.'
        format.html { redirect_to(@configkey) }
        format.xml  { render :xml => @configkey, :status => :created, :location => @configkey }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @configkey.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /configkeys/1
  # PUT /configkeys/1.xml
  def update
    @configkey = Configkey.find(params[:id])

    respond_to do |format|
      if @configkey.update_attributes(params[:configkey])
        flash[:notice] = 'Configkey was successfully updated.'
        format.html { redirect_to(@configkey) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @configkey.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /configkeys/1
  # DELETE /configkeys/1.xml
  def destroy
    @configkey = Configkey.find(params[:id])
    @configkey.destroy

    respond_to do |format|
      format.html { redirect_to(configkeys_url) }
      format.xml  { head :ok }
    end
  end
end
