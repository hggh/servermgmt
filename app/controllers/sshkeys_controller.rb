class SshkeysController < ApplicationController
  # GET /sshkeys
  # GET /sshkeys.xml
  def index
    if params[:search]
      @sshkeys = Sshkey.where("name ~* ?", params[:search])
    else
      @sshkeys = Sshkey.all  
    end
    

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sshkeys }
      format.js { render :layout => false }
    end
  end

  def show
    @sshkey = Sshkey.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sshkey }
    end
  end

  def new
    @sshkey = Sshkey.new

    respond_to do |format|
      format.html # new.html.erb
      format.js { render :layout => false }
      format.xml  { render :xml => @sshkey }
    end
  end

  def edit
    @sshkey = Sshkey.find(params[:id])
    
    respond_to do |format|
      format.html
      format.js { render :layout => false }
    end
  end

  def create
    @sshkey = Sshkey.new(params[:sshkey])

    respond_to do |format|
      if @sshkey.save
        @sshkeys = Sshkey.all
        format.html { redirect_to(sshkeys_url, :notice => 'Sshkey was successfully created.') }
        format.js { render :layout => false }
        format.xml  { render :xml => @sshkey, :status => :created, :location => @sshkey }
      else
        format.html { render :action => "new" }
        format.js { render :layout => false }
        format.xml  { render :xml => @sshkey.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @sshkey = Sshkey.find(params[:id])

    respond_to do |format|
      if @sshkey.update_attributes(params[:sshkey])
        @sshkeys = Sshkey.all
        format.html { redirect_to(@sshkey, :notice => 'Sshkey was successfully updated.') }
        format.js { render :layout => false }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.js { render :layout => false }
        format.xml  { render :xml => @sshkey.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @sshkey = Sshkey.find(params[:id])
    @sshkey.destroy
    @sshkeys = Sshkey.all

    respond_to do |format|
      format.html { redirect_to(sshkeys_url) }
      format.js { render :layout => false }
      format.xml  { head :ok }
    end
  end
end
