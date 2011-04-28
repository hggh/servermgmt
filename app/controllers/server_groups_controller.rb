class ServerGroupsController < ApplicationController
  def index
    @server_groups = ServerGroup.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def addpuppetcfgvalue
    @server_group = ServerGroup.find(params[:id])
    @configkey_value = ConfigkeyValue.new

    respond_to do |format|
      format.html
    end
  end

  def show
    @server_group = ServerGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def new
    @server_group = ServerGroup.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
    @server_group = ServerGroup.find(params[:id])
  end

  def create
    @server_group = ServerGroup.new(params[:server_group])

    respond_to do |format|
      if @server_group.save
        flash[:notice] = 'ServerGroup was successfully created.'
        format.html { redirect_to(@server_group) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @server_group = ServerGroup.find(params[:id])

    respond_to do |format|
      if @server_group.update_attributes(params[:server_group])
        flash[:notice] = 'ServerGroup was successfully updated.'
        format.html { redirect_to(@server_group) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @server_group = ServerGroup.find(params[:id])
    @server_group.destroy

    respond_to do |format|
      format.html { redirect_to(server_groups_url) }
    end
  end
  
  def newmember
    @server_group = ServerGroup.find(params[:id])
    @server_group_member = ServerGroupMember.new
    respond_to do |format|
      format.html
    end
  end
  
  def addmember
    @server_group_member = ServerGroupMember.new(params[:server_group_member])
    
    respond_to do |format|
      if @server_group_member.save
        flash[:notice] = 'Server was successfully added.'
        format.html { redirect_to(:controller => 'server_groups' ) }
      else
        # FIXME: error handling
        format.html { render :action => "index" }
      end
    end    
  end
  
  def delmember
    @server_group_member = ServerGroupMember.find(params[:id])
    server = Server.find(@server_group_member.server_id)
    server_group = ServerGroup.find(@server_group_member.server_group_id)
    if @server_group_member.auto_add == true
      flash[:error] = 'Server is in Server Group via Group Regexp - Can not removed!'
    else
      @server_group_member.destroy
      flash[:notice] = 'Server was successfully droped from Server Group.'
    end

    respond_to do |format|
      format.html {
        
        if params[:from] == "server_group_view" 
          redirect_to(server_group)
        elsif params[:from] == "server_view"
          redirect_to(server)
        end
      }
    end
  end
end
