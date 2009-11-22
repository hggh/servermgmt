class ServersController < ApplicationController
  def index
      @servers = Server.find(:all)

          respond_to do |format|
	        format.html # index.html.erb
		      format.xml  { render :xml => @servers }
		          end

  end

  def show
  end

  def new
  end

  def edit
  end

  def destory
  end

end
