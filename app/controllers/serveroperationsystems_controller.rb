class ServeroperationsystemsController < ApplicationController
  def index
    @serveroperationsystems = Serveroperationsystem.find(:all)

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @serveroperationsystem = Serveroperationsystem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def new
    @serveroperationsystem = Serveroperationsystem.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
    @serveroperationsystem = Serveroperationsystem.find(params[:id])
  end

  def create
    @serveroperationsystem = Serveroperationsystem.new(params[:serveroperationsystem])

    respond_to do |format|
      if @serveroperationsystem.save
        flash[:notice] = 'Serveroperationsystem was successfully created.'
        format.html { redirect_to(@serveroperationsystem) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @serveroperationsystem = Serveroperationsystem.find(params[:id])

    respond_to do |format|
      if @serveroperationsystem.update_attributes(params[:serveroperationsystem])
        flash[:notice] = 'Serveroperationsystem was successfully updated.'
        format.html { redirect_to(@serveroperationsystem) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @serveroperationsystem = Serveroperationsystem.find(params[:id])
    @serveroperationsystem.destroy

    respond_to do |format|
      format.html { redirect_to(serveroperationsystems_url) }
    end
  end
end
