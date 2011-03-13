class SshusersController < ApplicationController
  # GET /sshusers
  # GET /sshusers.xml
  def index
    @sshusers = Sshuser.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sshusers }
    end
  end

  # GET /sshusers/1
  # GET /sshusers/1.xml
  def show
    @sshuser = Sshuser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sshuser }
    end
  end

  # GET /sshusers/new
  # GET /sshusers/new.xml
  def new
    @sshuser = Sshuser.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sshuser }
    end
  end

  # GET /sshusers/1/edit
  def edit
    @sshuser = Sshuser.find(params[:id])
  end

  # POST /sshusers
  # POST /sshusers.xml
  def create
    @sshuser = Sshuser.new(params[:sshuser])

    respond_to do |format|
      if @sshuser.save
        format.html { redirect_to(@sshuser, :notice => 'Sshuser was successfully created.') }
        format.xml  { render :xml => @sshuser, :status => :created, :location => @sshuser }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sshuser.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sshusers/1
  # PUT /sshusers/1.xml
  def update
    @sshuser = Sshuser.find(params[:id])

    respond_to do |format|
      if @sshuser.update_attributes(params[:sshuser])
        format.html { redirect_to(@sshuser, :notice => 'Sshuser was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sshuser.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sshusers/1
  # DELETE /sshusers/1.xml
  def destroy
    @sshuser = Sshuser.find(params[:id])
    @sshuser.destroy

    respond_to do |format|
      format.html { redirect_to(sshusers_url) }
      format.xml  { head :ok }
    end
  end
end
