class ServersController < ApplicationController
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
