class ServersController < ApplicationController
  def createip
    @ip = Ip.new(params[:ip])
    
    respond_to do |format|
      if @ip.save
        flash[:notice] = 'IP address was successfully created.'
        format.html { redirect_to(:controller => 'servers', :action => "show", :id=> @ip.server_id ) }
      else
        @server = Server.find(@ip.server_id)
        format.html { render :action => "addip" }
      end
    end
    
  end

  def createmac
    @servermac = ServerMac.new(params[:server_mac])
    
    respond_to do |format|
      if @servermac.save
        flash[:notice] = 'MAC address was successfully created.'
        format.html { redirect_to(:controller => 'servers', :action => "show", :id=> @servermac.server_id ) }
      else
        @server = Server.find(@servermac.server_id)
        format.html { render :action => "addmac" }
      end
    end
    
  end
  
  def createpuppetcfgvalue
    @configkey_value = ConfigkeyValue.new(params[:configkey_value])
    respond_to do |format|
      if @configkey_value.save
        flash[:notice] = 'Puppet Cfg Value was successfully created.'
        format.html { redirect_to(:controller => 'servers', :action => "show", :id=> @configkey_value.server_id ) }
      else
        @server = Server.find(@configkey_value.server_id)
        format.html { render :action => "addpuppetcfgvalue" }
      end
    end
  end
  
  def addpuppetcfgvalue
    @configkey_value = ConfigkeyValue.new
    @server = Server.find(params[:id])
    respond_to do |format|
      format.html
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
    @servers = Server.find(:all)
    
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  def show
    @server = Server.find(params[:id])
    @server_virtual = ServerVirtual.new
    respond_to do |format|
      format.html # show.html.erb
    end
    rescue ActiveRecord::RecordNotFound
      render_404
  end
  
  def new
    @server = Server.new
    
    respond_to do |format|
      format.html
    end
    
  end
  
  def addip
    @ip = Ip.new
    @networks = Network.find(:all)
    @server = Server.find(params[:id])
    respond_to do |format|
      format.html
    end
  end
  
  def addmac
    @server_mac = ServerMac.new
    @server = Server.find(params[:id])
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
      else
        format.html { render :action => "new" }
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
