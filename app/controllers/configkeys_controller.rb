class ConfigkeysController < ApplicationController
  def index
    @configkeys = Configkey.all

    respond_to do |format|
      format.html
    end
  end

  def show
    @configkey = Configkey.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def new
    @configkey = Configkey.new

    respond_to do |format|
      format.html
    end
  end

  def edit
    @configkey = Configkey.find(params[:id])
  end

  def create
    @configkey = Configkey.new(params[:configkey])

    respond_to do |format|
      if @configkey.save
        flash[:notice] = 'Configkey was successfully created.'
        format.html { redirect_to(@configkey) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @configkey = Configkey.find(params[:id])

    respond_to do |format|
      if @configkey.update_attributes(params[:configkey])
        flash[:notice] = 'Configkey was successfully updated.'
        format.html { redirect_to(@configkey) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @configkey = Configkey.find(params[:id])
    @configkey.destroy

    respond_to do |format|
      format.html { redirect_to(configkeys_url) }
    end
  end
end
