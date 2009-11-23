class ServertypesController < ApplicationController
  # GET /servertypes
  #helper :servertype
  # GET /servertypes.xml
  def index
    @servertypes = Servertype.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @servertypes }
    end
  end

  # GET /servertypes/1
  # GET /servertypes/1.xml
  def show
    @servertype = Servertype.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @servertype }
    end
  end

  # GET /servertypes/new
  # GET /servertypes/new.xml
  def new
    @servertype = Servertype.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @servertype }
    end
  end

  # GET /servertypes/1/edit
  def edit
    @servertype = Servertype.find(params[:id])
  end

  # POST /servertypes
  # POST /servertypes.xml
  def create
    @servertype = Servertype.new(params[:servertype])

    respond_to do |format|
      if @servertype.save
        flash[:notice] = 'Servertype was successfully created.'
        format.html { redirect_to(@servertype) }
        format.xml  { render :xml => @servertype, :status => :created, :location => @servertype }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @servertype.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /servertypes/1
  # PUT /servertypes/1.xml
  def update
    @servertype = Servertype.find(params[:id])

    respond_to do |format|
      if @servertype.update_attributes(params[:servertype])
        flash[:notice] = 'Servertype was successfully updated.'
        format.html { redirect_to(@servertype) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @servertype.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /servertypes/1
  # DELETE /servertypes/1.xml
  def destroy
    @servertype = Servertype.find(params[:id])
    @servertype.destroy

    respond_to do |format|
      format.html { redirect_to(servertypes_url) }
      format.xml  { head :ok }
    end
  end
end
