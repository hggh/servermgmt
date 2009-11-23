class IpsController < ApplicationController

  def create
    @ip = Ip.new(params[:ip])

    respond_to do |format|
      if @ip.save
        flash[:notice] = 'IP address was successfully created.'
        format.html { redirect_to(:controller => 'servers', :action => "show", :id=> @ip.server_id ) }
      else
        format.html { render :action => "new" }
      end
    end

  end

end
