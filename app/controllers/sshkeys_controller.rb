class SshkeysController < ApplicationController
  # GET /sshkeys
  # GET /sshkeys.xml
  def index
    @sshkeys = Sshkey.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sshkeys }
    end
  end

  # GET /sshkeys/1
  # GET /sshkeys/1.xml
  def show
    @sshkey = Sshkey.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sshkey }
    end
  end

  # GET /sshkeys/new
  # GET /sshkeys/new.xml
  def new
    @sshkey = Sshkey.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sshkey }
    end
  end

  # GET /sshkeys/1/edit
  def edit
    @sshkey = Sshkey.find(params[:id])
  end

  # POST /sshkeys
  # POST /sshkeys.xml
  def create
    @sshkey = Sshkey.new(params[:sshkey])

    respond_to do |format|
      if @sshkey.save
        format.html { redirect_to(@sshkey, :notice => 'Sshkey was successfully created.') }
        format.xml  { render :xml => @sshkey, :status => :created, :location => @sshkey }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sshkey.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sshkeys/1
  # PUT /sshkeys/1.xml
  def update
    @sshkey = Sshkey.find(params[:id])

    respond_to do |format|
      if @sshkey.update_attributes(params[:sshkey])
        format.html { redirect_to(@sshkey, :notice => 'Sshkey was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sshkey.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sshkeys/1
  # DELETE /sshkeys/1.xml
  def destroy
    @sshkey = Sshkey.find(params[:id])
    @sshkey.destroy

    respond_to do |format|
      format.html { redirect_to(sshkeys_url) }
      format.xml  { head :ok }
    end
  end
end
