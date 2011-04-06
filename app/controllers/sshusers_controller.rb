class SshusersController < ApplicationController
  def index
    @sshusers = Sshuser.allByServerByUser

    respond_to do |format|
      format.html
      format.xml  { render :xml => @sshusers }
    end
  end

  def show
    @sshuser = Sshuser.find(params[:id])
    @sshuser_mbr = SshuserMbr.new('sshuser_id' => @sshuser.id)

    respond_to do |format|
      format.html
      format.xml  { render :xml => @sshuser }
    end
  end

  def new
    @sshuser = Sshuser.new

    respond_to do |format|
      format.html
      format.xml  { render :xml => @sshuser }
    end
  end

  def edit
    @sshuser = Sshuser.find(params[:id])
  end

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

  def destroy
    @sshuser = Sshuser.find(params[:id])
    @sshuser.destroy

    respond_to do |format|
      format.html { redirect_to(sshusers_url) }
      format.xml  { head :ok }
    end
  end
end
