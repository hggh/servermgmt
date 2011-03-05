class ServerKeyValuesController < ApplicationController
  def new
    @key = ServerKeyValue.new
    @server = Server.find(params[:server_id])
    respond_to do |format|
      format.html
    end
  end
  def show
    @key = ServerKeyValue.find(params[:id])
    @server = Server.find(params[:server_id])
    respond_to do |format|
      format.html
      format.xml { render :xml => @key}
    end
  end
  def create
    @key = ServerKeyValue.new(params[:server_key_value])
    @server = Server.find(params[:server_id])

    respond_to do |format|
      if @key.save
        flash[:notice] = 'Key address was successfully created.'
        format.html { redirect_to(:controller => 'servers', :action => "show", :id=> @key.server_id ) }
        format.xml  { head :created }
      else
        @server = Server.find(@key.server_id)
        format.html { render :action => "new" }
        format.xml  { render :xml => @key.errors, :status => :unprocessable_entity }
      end
    end
  end
end