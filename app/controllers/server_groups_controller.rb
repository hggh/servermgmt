class ServerGroupsController < ApplicationController
  # GET /server_groups
  # GET /server_groups.xml
  def index
    @server_groups = ServerGroup.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @server_groups }
    end
  end

  # GET /server_groups/1
  # GET /server_groups/1.xml
  def show
    @server_group = ServerGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @server_group }
    end
  end

  # GET /server_groups/new
  # GET /server_groups/new.xml
  def new
    @server_group = ServerGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @server_group }
    end
  end

  # GET /server_groups/1/edit
  def edit
    @server_group = ServerGroup.find(params[:id])
  end

  # POST /server_groups
  # POST /server_groups.xml
  def create
    @server_group = ServerGroup.new(params[:server_group])

    respond_to do |format|
      if @server_group.save
        flash[:notice] = 'ServerGroup was successfully created.'
        format.html { redirect_to(@server_group) }
        format.xml  { render :xml => @server_group, :status => :created, :location => @server_group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @server_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /server_groups/1
  # PUT /server_groups/1.xml
  def update
    @server_group = ServerGroup.find(params[:id])

    respond_to do |format|
      if @server_group.update_attributes(params[:server_group])
        flash[:notice] = 'ServerGroup was successfully updated.'
        format.html { redirect_to(@server_group) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @server_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /server_groups/1
  # DELETE /server_groups/1.xml
  def destroy
    @server_group = ServerGroup.find(params[:id])
    @server_group.destroy

    respond_to do |format|
      format.html { redirect_to(server_groups_url) }
      format.xml  { head :ok }
    end
  end
end
