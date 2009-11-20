class IptypesController < ApplicationController
  # GET /iptypes
  # GET /iptypes.xml
  def index
    @iptypes = Iptype.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @iptypes }
    end
  end

  # GET /iptypes/1
  # GET /iptypes/1.xml
  def show
    @iptype = Iptype.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @iptype }
    end
  end

  # GET /iptypes/new
  # GET /iptypes/new.xml
  def new
    @iptype = Iptype.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @iptype }
    end
  end

  # GET /iptypes/1/edit
  def edit
    @iptype = Iptype.find(params[:id])
  end

  # POST /iptypes
  # POST /iptypes.xml
  def create
    @iptype = Iptype.new(params[:iptype])

    respond_to do |format|
      if @iptype.save
        flash[:notice] = 'Iptype was successfully created.'
        format.html { redirect_to(@iptype) }
        format.xml  { render :xml => @iptype, :status => :created, :location => @iptype }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @iptype.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /iptypes/1
  # PUT /iptypes/1.xml
  def update
    @iptype = Iptype.find(params[:id])

    respond_to do |format|
      if @iptype.update_attributes(params[:iptype])
        flash[:notice] = 'Iptype was successfully updated.'
        format.html { redirect_to(@iptype) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @iptype.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /iptypes/1
  # DELETE /iptypes/1.xml
  def destroy
    @iptype = Iptype.find(params[:id])
    @iptype.destroy

    respond_to do |format|
      format.html { redirect_to(iptypes_url) }
      format.xml  { head :ok }
    end
  end
end
