class ServermacsController < ApplicationController
  
  def destroy
    @servermac = Servermac.find(params[:id])
    server_id = @servermac.server_id
    @servermac.destroy
    respond_to do |format|
      flash[:notice] = 'MAC address was successfully deleted.'
      format.html { redirect_to(:controller => 'servers', :action => "show", :id=> server_id ) }
    end

  end
end
