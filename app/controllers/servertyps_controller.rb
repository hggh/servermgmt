class ServertypsController < ApplicationController
  # GET /servertyps
  # GET /servertyps.xml
  def index
    @servertyps = Servertyp.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @servertyps }
    end
  end

  # GET /servertyps/1
  # GET /servertyps/1.xml
  def show
    @servertyp = Servertyp.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @servertyp }
    end
  end

  # GET /servertyps/new
  # GET /servertyps/new.xml
  def new
    @servertyp = Servertyp.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @servertyp }
    end
  end

  # GET /servertyps/1/edit
  def edit
    @servertyp = Servertyp.find(params[:id])
  end

  # POST /servertyps
  # POST /servertyps.xml
  def create
    @servertyp = Servertyp.new(params[:servertyp])

    respond_to do |format|
      if @servertyp.save
        flash[:notice] = 'Servertyp was successfully created.'
        format.html { redirect_to(@servertyp) }
        format.xml  { render :xml => @servertyp, :status => :created, :location => @servertyp }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @servertyp.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /servertyps/1
  # PUT /servertyps/1.xml
  def update
    @servertyp = Servertyp.find(params[:id])

    respond_to do |format|
      if @servertyp.update_attributes(params[:servertyp])
        flash[:notice] = 'Servertyp was successfully updated.'
        format.html { redirect_to(@servertyp) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @servertyp.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /servertyps/1
  # DELETE /servertyps/1.xml
  def destroy
    @servertyp = Servertyp.find(params[:id])
    @servertyp.destroy

    respond_to do |format|
      format.html { redirect_to(servertyps_url) }
      format.xml  { head :ok }
    end
  end
end
