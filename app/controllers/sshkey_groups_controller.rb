class SshkeyGroupsController < ApplicationController
  def index
    if params[:search]
      @sshkey_groups = SshkeyGroup.where("name ~* ?", params[:search])
    else
      @sshkey_groups = SshkeyGroup.all
    end

    respond_to do |format|
      format.html
      format.js { render :layout => false }
    end
  end

  def show
    @sshkey_group = SshkeyGroup.find(params[:id])
    @sshkey_group_mbr = SshkeyGroupMbr.new

    respond_to do |format|
      format.html
      format.js { render :layout => false }
      format.xml  { render :xml => @sshkey_group }
    end
  end

  def new
    @sshkey_group = SshkeyGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sshkey_group }
      format.js { render :layout => false }
    end
  end

  # GET /sshkey_groups/1/edit
  def edit
    @sshkey_group = SshkeyGroup.find(params[:id])
    respond_to do |format|
      format.html
      format.js { render :layout => false }
    end
  end

  def create
    @sshkey_group = SshkeyGroup.new(params[:sshkey_group])

    respond_to do |format|
      if @sshkey_group.save
        @sshkey_groups = SshkeyGroup.all
        format.html { redirect_to(@sshkey_group, :notice => 'Sshkey group was successfully created.') }
        format.js { render :layout => false }
        format.xml  { render :xml => @sshkey_group, :status => :created, :location => @sshkey_group }
      else
        format.html { render :action => "new" }
        format.js { render :layout => false }
        format.xml  { render :xml => @sshkey_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sshkey_groups/1
  # PUT /sshkey_groups/1.xml
  def update
    @sshkey_group = SshkeyGroup.find(params[:id])

    respond_to do |format|
      if @sshkey_group.update_attributes(params[:sshkey_group])
        @sshkey_groups = SshkeyGroup.all
        format.html { redirect_to(@sshkey_group, :notice => 'Sshkey group was successfully updated.') }
        format.js { render :layout => false }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.js { render :layout => false }
        format.xml  { render :xml => @sshkey_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @sshkey_group = SshkeyGroup.find(params[:id])
    @sshkey_group.destroy
    @sshkey_groups = SshkeyGroup.all

    respond_to do |format|
      format.html { redirect_to(sshkey_groups_url) }
      format.xml  { head :ok }
      format.js { render :layout => false }
    end
  end
end
