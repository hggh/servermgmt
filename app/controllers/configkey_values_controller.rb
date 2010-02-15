class ConfigkeyValuesController < ApplicationController
  
  def destroy
    @configkey_value = ConfigkeyValue.find(params[:id])
    server_id = @configkey_value.server_id
    server_group_id = @configkey_value.server_group_id
    @configkey_value.destroy
  
    respond_to do |format|
      flash[:notice] = 'Puppet Configuration Key was deleted!'
      if params[:from] and params[:from] == "group_view"
        format.html { redirect_to(:controller => 'server_groups', :action => "show", :id=> server_group_id ) }
      else
        format.html { redirect_to(:controller => 'servers', :action => "show", :id=> server_id ) }
      end
    end
  end
  
  def create
    @configkey_value = ConfigkeyValue.new(params[:configkey_value])
    respond_to do |format|
      if @configkey_value.save
        flash[:notice] = 'Puppet Cfg Value was successfully created.'
        if @configkey_value.server_group_id
          format.html { redirect_to(:controller => 'server_groups', :action => "show", :id=> @configkey_value.server_group_id  ) }
        end
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @configkey_value = ConfigkeyValue.find(params[:id])
    server_id = @configkey_value.server_id
    server_group_id = @configkey_value.server_group_id

    respond_to do |format|
      if @configkey_value.update_attributes(params[:configkey_value])
        flash[:notice] = 'Puppet Configuration Key was successfully updated.'
        if params[:from] and params[:from] == "group_view"
          format.html { redirect_to(:controller => 'server_groups', :action => "show", :id=> server_group_id ) }
        else
          format.html { redirect_to(:controller => 'servers', :action => "show", :id=> server_id ) }
        end
      else
        format.html { redirect_to(:controller => 'servers', :action => "show", :id=> server_id ) }
      end
    end
  end

end