class IptypesController < ApplicationController
  helper :iptypes
  def index
    @iptypes = Iptype.find(:all)

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @iptype = Iptype.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def new
    @iptype = Iptype.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
    @iptype = Iptype.find(params[:id])
  end

  def create
    @iptype = Iptype.new(params[:iptype])

    respond_to do |format|
      if @iptype.save
        flash[:notice] = 'Iptype was successfully created.'
        format.html { redirect_to(@iptype) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @iptype = Iptype.find(params[:id])

    respond_to do |format|
      if @iptype.update_attributes(params[:iptype])
        flash[:notice] = 'Iptype was successfully updated.'
        format.html { redirect_to(@iptype) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @iptype = Iptype.find(params[:id])
    @iptype.destroy

    respond_to do |format|
      format.html { redirect_to(iptypes_url) }
      format.xml  { head :ok }
    end
  end
end
