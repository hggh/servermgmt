class IpsController < ApplicationController
  
  def destroy
    @ip = Ip.find(params[:id])
    server_id = @ip.server_id
    @ip.destroy
    
    respond_to do |format|
      flash[:notice] = 'IP address was successfully deleted.'
      format.html { redirect_to(:controller => 'servers', :action => "show", :id=> server_id ) }
    end
  end
  
end
