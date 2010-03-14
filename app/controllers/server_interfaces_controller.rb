class ServerInterfacesController < ApplicationController

  def show
    @server = Server.find(params[:server_id])
    @server_interface = ServerInterface.find(params[:id])

    respond_to do |format|
      format.html
    end
  end
end