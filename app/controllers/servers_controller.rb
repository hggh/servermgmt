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
  end

  def edit
  end

  def destory
  end

end
