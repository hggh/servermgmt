class ServertypesController < ApplicationController
  def index
    @servertypes = Servertype.find(:all)

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @servertype = Servertype.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def new
    @servertype = Servertype.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /servertypes/1/edit
  def edit
    @servertype = Servertype.find(params[:id])
  end

  def create
    @servertype = Servertype.new(params[:servertype])

    respond_to do |format|
      if @servertype.save
        flash[:notice] = 'Servertype was successfully created.'
        format.html { redirect_to(@servertype) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @servertype = Servertype.find(params[:id])

    respond_to do |format|
      if @servertype.update_attributes(params[:servertype])
        flash[:notice] = 'Servertype was successfully updated.'
        format.html { redirect_to(@servertype) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @servertype = Servertype.find(params[:id])
    @servertype.destroy

    respond_to do |format|
      format.html { redirect_to(servertypes_url) }
    end
  end
end
