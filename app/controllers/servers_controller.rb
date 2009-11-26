class ServersController < ApplicationController
  def createip
    @ip = Ip.new(params[:ip])
    
    respond_to do |format|
      if @ip.save
        flash[:notice] = 'IP address was successfully created.'
        format.html { redirect_to(:controller => 'servers', :action => "show", :id=> @ip.server_id ) }
      else
        @server = Server.find(@ip.server_id)
        format.html { render :action => "addip" }
      end
    end
    
  end
  
  def index
    @servers = Server.find(:all)
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @servers }
    end
  end
  
  def show
    @server = Server.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
    end
  end
  
  def new
    @server = Server.new
    
    respond_to do |format|
      format.html # new.html.erb
    end
    
  end
  
  def addip
    @ip = Ip.new
    @networks = Network.find(:all)
    @server = Server.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
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
  
  def destory
  end
  
end
