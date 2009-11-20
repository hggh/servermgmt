class IpsController < ApplicationController
  def show
  	@network = Network.find(params[:network_id])
	@ips = @network.ips.find(params[:id])
  end

end
