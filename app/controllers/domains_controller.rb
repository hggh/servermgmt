class DomainsController < ApplicationController
  def index
    @servers = Server.find(:all)
    
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  def show
    @server = Server.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
    end
    rescue ActiveRecord::RecordNotFound
      render_404
  end
  
  def new
    @server = Server.new
    
    respond_to do |format|
      format.html # new.html.erb
    end
    
  end
  
  def create
    @server = Server.new(params[:server])
    
    respond_to do |format|
      if @server.save
        flash[:notice] = 'Server was successfully created.'
        format.html { redirect_to(@server) }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def edit
    @server = Server.find(params[:id])
  end
  
  def destroy
    @server = Server.find(params[:id])
    @server.destroy

    respond_to do |format|
      format.html { redirect_to(servers_url) }
    end
  end
  def update
    @server = Server.find(params[:id])

    respond_to do |format|
      if @server.update_attributes(params[:server])
        flash[:notice] = 'Server was successfully updated.'
        format.html { redirect_to(@server) }
      else
        format.html { render :action => "edit" }
      end
    end
  end  
end
