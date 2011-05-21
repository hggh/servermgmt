class ServersController < ApplicationController
  def puppet_userlist
    @server = Server.find(params[:id])
    @users = nil
    if Setting.get('puppet') == "true" and  @server.getPuppet
        @users = @server.getPuppet.getFactValue('users')
    end
    respond_to do |format|
      format.js { render :layout => false }
    end
  end

  def addvirtual
    @server_virtual = ServerVirtual.new(params[:server_virtual])
    respond_to do |format|
      if @server_virtual.save
        flash[:notice] = 'Virtual System was connected to hardware.'
        format.html { redirect_to(:controller => 'servers', :action => "show", :id=> @server_virtual.hardware_id ) }
      else
        @server = Server.find(@server_virtual.hardware_id)
        format.html { render :action => "show" }
      end
    end
  end
  
  def dropvirtual
    @server_virtual = ServerVirtual.find(params[:id])
    server_id = @server_virtual.hardware_id
    @server_virtual.destroy
    
    respond_to do |format|
      flash[:notice] = 'Virtual System was disconnected to hardware.'
      format.html { redirect_to(:controller => 'servers', :action => "show", :id=> server_id ) }
    end
  end
  
  def index
    @servers = Server.find(:all, :include => :domain, :order => 'servers.name,domains.name')
    
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  def show
    @server = Server.find(params[:id])
    @server_virtual = ServerVirtual.new
    respond_to do |format|
      format.html # show.html.erb
      format.xml
    end
  end
  
  def new
    @server = Server.new
    
    respond_to do |format|
      format.html
    end
    
  end
  
  def create
    @server = Server.new(params[:server])
    
    respond_to do |format|
      if @server.save
        flash[:notice] = 'Server was successfully created.'
        format.html { redirect_to(@server) }
        format.xml  { render :xml => @server, :status => :created, :location => @server }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @server.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def edit
    @server = Server.find(params[:id])
  end
  
  def destroy
    @server = Server.find(params[:id])
    @server.destroy

    respond_to do |format|
      format.html { redirect_to(servers_url) }
    end
  end
  def update
    @server = Server.find(params[:id])

    respond_to do |format|
      if @server.update_attributes(params[:server])
        flash[:notice] = 'Server was successfully updated.'
        format.html { redirect_to(@server) }
      else
        format.html { render :action => "edit" }
      end
    end
  end  
end
