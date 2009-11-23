class ServermacsController < ApplicationController
  # GET /servermacs
  # GET /servermacs.xml
  def index
    @servermacs = Servermac.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @servermacs }
    end
  end

  # GET /servermacs/1
  # GET /servermacs/1.xml
  def show
    @servermac = Servermac.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @servermac }
    end
  end

  # GET /servermacs/new
  # GET /servermacs/new.xml
  def new
    @servermac = Servermac.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @servermac }
    end
  end

  # GET /servermacs/1/edit
  def edit
    @servermac = Servermac.find(params[:id])
  end

  # POST /servermacs
  # POST /servermacs.xml
  def create
    @servermac = Servermac.new(params[:servermac])

    respond_to do |format|
      if @servermac.save
        flash[:notice] = 'Servermac was successfully created.'
        format.html { redirect_to(@servermac) }
        format.xml  { render :xml => @servermac, :status => :created, :location => @servermac }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @servermac.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /servermacs/1
  # PUT /servermacs/1.xml
  def update
    @servermac = Servermac.find(params[:id])

    respond_to do |format|
      if @servermac.update_attributes(params[:servermac])
        flash[:notice] = 'Servermac was successfully updated.'
        format.html { redirect_to(@servermac) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @servermac.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /servermacs/1
  # DELETE /servermacs/1.xml
  def destroy
    @servermac = Servermac.find(params[:id])
    @servermac.destroy

    respond_to do |format|
      format.html { redirect_to(servermacs_url) }
      format.xml  { head :ok }
    end
  end
end
