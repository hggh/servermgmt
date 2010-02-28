class NameserversController < ApplicationController
  def index
    @nameservers = Nameserver.find(:all)

    respond_to do |format|
      format.html
    end
  end

  def show
    @nameserver = Nameserver.find(params[:id])

    respond_to do |format|
      format.html
    end
  end
  
  def new
    @nameserver = Nameserver.new

    respond_to do |format|
      format.html
    end
  end

  def edit
    @nameserver = Nameserver.find(params[:id])
  end

  def create
    @nameserver = Nameserver.new(params[:nameserver])

    respond_to do |format|
      if @nameserver.save
        flash[:notice] = 'Nameserver was successfully created.'
        format.html { redirect_to(@nameserver) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @nameserver = Nameserver.find(params[:id])

    respond_to do |format|
      if @nameserver.update_attributes(params[:nameserver])
        flash[:notice] = 'Nameserver was successfully updated.'
        format.html { redirect_to(@nameserver) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @nameserver = Nameserver.find(params[:id])
    @nameserver.destroy

    respond_to do |format|
      format.html { redirect_to(nameservers_url) }
    end
  end

end