class ServerInterfacesController < ApplicationController

  def show
    @server = Server.find(params[:server_id])
    @server_interface = ServerInterface.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def selectinterface
    @interface_selected = Interface.find(:first, :conditions =>[ "name=?" , params[:facter_interface] ] )
    if @interface_selected
      interfaceId =  @interface_selected.id
    else
      # No Interface found, we will add it into interfaces table
      @interface = Interface.new({:name => params[:facter_interface]})
      @interface.save
      interfaceId = @interface.id
    end
    @server_interface = ServerInterface.new
    @server_interface.interface_id = interfaceId
    render( :partial => 'interface_list',:layout => false)
  end

  def update
    @server = Server.find(params[:server_id])
    @server_interface = ServerInterface.find(params[:id])

    respond_to do |format|
      if @server_interface.update_attributes(params[:server_interface])
        flash[:notice] = 'Interface was successfully updated.'
        format.html { redirect_to(@server) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def new
    @server = Server.find(params[:server_id])
    @server_interface = ServerInterface.new
    server_routes = ServerInterface.find(:all, :conditions => "server_id=#{@server.id}")
    if server_routes and server_routes.count > 0
      @server_interface.alias = 'true'
    else
      @server_interface.alias = 'false'
    end
    server_aliases = ServerInterface.find(:all, :conditions => "server_id=#{@server.id} AND default_gw=true")
    if server_aliases and server_aliases.count > 0
      @server_interface.default_gw = 'false'
    else
      @server_interface.default_gw = 'true'
    end
  end

  def edit
    @server = Server.find(params[:server_id])
    @server_interface = ServerInterface.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def create
    @server = Server.find(params[:server_id])
    @server_interface = ServerInterface.new(params[:server_interface])
    
    respond_to do |format|
      if @server_interface.save
        flash[:notice] = 'Interface was successfully created.'
        format.html { redirect_to(@server) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def destroy
    @server = Server.find(params[:server_id])
    @server_interface = ServerInterface.find(params[:id])
    @server_interface.destroy
    respond_to do |format|
      flash[:notice] = 'Interface was successfully deleted.'
      format.html { redirect_to(@server) }
    end
  end
end