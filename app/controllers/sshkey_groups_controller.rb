class SshkeyGroupsController < ApplicationController
  # GET /sshkey_groups
  # GET /sshkey_groups.xml
  def index
    @sshkey_groups = SshkeyGroup.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sshkey_groups }
    end
  end

  # GET /sshkey_groups/1
  # GET /sshkey_groups/1.xml
  def show
    @sshkey_group = SshkeyGroup.find(params[:id])
    @sshkey_group_mbr = SshkeyGroupMbr.new

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sshkey_group }
    end
  end

  # GET /sshkey_groups/new
  # GET /sshkey_groups/new.xml
  def new
    @sshkey_group = SshkeyGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sshkey_group }
    end
  end

  # GET /sshkey_groups/1/edit
  def edit
    @sshkey_group = SshkeyGroup.find(params[:id])
  end

  # POST /sshkey_groups
  # POST /sshkey_groups.xml
  def create
    @sshkey_group = SshkeyGroup.new(params[:sshkey_group])

    respond_to do |format|
      if @sshkey_group.save
        format.html { redirect_to(@sshkey_group, :notice => 'Sshkey group was successfully created.') }
        format.xml  { render :xml => @sshkey_group, :status => :created, :location => @sshkey_group }
      else
        format.html { render :action => "new" }
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
        format.html { redirect_to(@sshkey_group, :notice => 'Sshkey group was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sshkey_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sshkey_groups/1
  # DELETE /sshkey_groups/1.xml
  def destroy
    @sshkey_group = SshkeyGroup.find(params[:id])
    @sshkey_group.destroy

    respond_to do |format|
      format.html { redirect_to(sshkey_groups_url) }
      format.xml  { head :ok }
    end
  end
end
