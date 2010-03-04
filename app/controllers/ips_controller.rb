class IpsController < ApplicationController
  
  def destroy
    @ip = Ip.find(params[:id])
    server_id  = @ip.server_id
    network_id = @ip.network_id
    @ip.destroy
    
    respond_to do |format|
      flash[:notice] = 'IP address was successfully deleted.'
      if params[:from] and params[:from] == "network_view"
        format.html { redirect_to(:controller => 'networks', :action => "show", :id => network_id) } 
      else
        format.html { redirect_to(:controller => 'servers', :action => "show", :id=> server_id ) }
      end
    end
  end

  def new
    @ip = Ip.new
    @networks = Network.find(:all)
    @server = Server.find(params[:server_id])
    respond_to do |format|
      format.html
    end
  end

  def create
    @ip = Ip.new(params[:ip])
    
    respond_to do |format|
      if @ip.save
        flash[:notice] = 'IP address was successfully created.'
        format.html { redirect_to(:controller => 'servers', :action => "show", :id=> @ip.server_id ) }
      else
        @server = Server.find(@ip.server_id)
        format.html { render :action => "new" }
      end
    end
  end

end
