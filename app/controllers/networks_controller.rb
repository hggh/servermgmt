class NetworksController < ApplicationController

  def index
    @networks = Network.find(:all)

    respond_to do |format|
      format.html
    end
  end

  def show
    @network = Network.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def new
    @network = Network.new

    respond_to do |format|
      format.html
    end
  end

  def edit
    @network = Network.find(params[:id])
  end

  def create
    @network = Network.new(params[:network])

    respond_to do |format|
      if @network.save
        flash[:notice] = 'Network was successfully created.'
        format.html { redirect_to(@network) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @network = Network.find(params[:id])

    respond_to do |format|
      if @network.update_attributes(params[:network])
        flash[:notice] = 'Network was successfully updated.'
        format.html { redirect_to(@network) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @network = Network.find(params[:id])
    @network.destroy

    respond_to do |format|
      format.html { redirect_to(networks_url) }
    end
  end
end
