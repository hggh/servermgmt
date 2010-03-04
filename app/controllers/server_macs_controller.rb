class ServerMacsController < ApplicationController
  
  def destroy
    @servermac = ServerMac.find(params[:id])
    server_id = @servermac.server_id
    @servermac.destroy
    respond_to do |format|
      flash[:notice] = 'MAC address was successfully deleted.'
      if session['server_mac'] and session['server_mac'] == "server_show"
        format.html { redirect_to(:controller => 'servers', :action => "show", :id=> server_id ) }
      else
        format.html { redirect_to('/server_macs') }
      end
      
    end   
  end
  
  def edit
    @server_mac = ServerMac.find(params[:id])
    @server = Server.find(@server_mac.server_id)
  end
  
  def new
    @server_mac = ServerMac.new
    @server = Server.find(params[:server_id])
    respond_to do |format|
      format.html
    end
  end
  
  def update
    @server_mac = ServerMac.find(params[:id])
    @server = Server.find(params[:server_id])
    
    respond_to do |format|
      if @server_mac.update_attributes(params[:server_mac])
        flash[:notice] = 'MAC Address was successfully updated.'
        format.html { redirect_to(@server) }
      else
        format.html { render :action => "edit" }
      end
    end
  end     
  
  def index
    @servermacs = ServerMac.find(:all)
  end
  
  def create
    @servermac = ServerMac.new(params[:server_mac])
    @server = Server.find(params[:server_id])
    
    respond_to do |format|
      if @servermac.save
        flash[:notice] = 'MAC address was successfully created.'
        format.html { redirect_to(@server) }
      else
        
        format.html { render :action => "new" }
      end
    end
    
  end
  
end
