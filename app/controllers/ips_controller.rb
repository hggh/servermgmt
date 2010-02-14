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
  
end
