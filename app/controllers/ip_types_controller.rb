class IpTypesController < ApplicationController
  def index
    @iptypes = IpType.find(:all)

    respond_to do |format|
      format.html
    end
  end

  def show
    @iptype = IpType.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def new
    @iptype = IpType.new

    respond_to do |format|
      format.html
    end
  end

  def edit
    @iptype = IpType.find(params[:id])
  end

  def create
    @iptype = IpType.new(params[:ip_type])

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
    @iptype = IpType.find(params[:id])

    respond_to do |format|
      if @iptype.update_attributes(params[:ip_type])
        flash[:notice] = 'Iptype was successfully updated.'
        format.html { redirect_to(@iptype) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @iptype = IpType.find(params[:id])
    @iptype.destroy

    respond_to do |format|
      format.html { redirect_to(iptypes_url) }
    end
  end
end
