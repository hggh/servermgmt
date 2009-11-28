class ServertypeHardwaresController < ApplicationController
  def create
    @servertypehardware = ServerTypeHardware.new(params[:servertypehardware])

    respond_to do |format|
      if @servertypehardware.save
        flash[:notice] = 'Server type Hardware was successfully created.'
        format.html { redirect_to(@servertypehardware) }
      else
        format.html { render :action => "new" }
      end
    end
  end
end