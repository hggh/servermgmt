class ConfigkeyValuesController < ApplicationController
  
  def destroy
    @configkey_value = ConfigkeyValue.find(params[:id])
    server_id = @configkey_value.server_id
    @configkey_value.destroy
  
    respond_to do |format|
      flash[:notice] = 'Puppet Configuration Key was deleted!'
      format.html { redirect_to(:controller => 'servers', :action => "show", :id=> server_id ) }
    end
  end
  
  def update
    @configkey_value = ConfigkeyValue.find(params[:id])
    server_id = @configkey_value.server_id

    respond_to do |format|
      if @configkey_value.update_attributes(params[:configkey_value])
        flash[:notice] = 'Puppet Configuration Key was successfully updated.'
        format.html { redirect_to(:controller => 'servers', :action => "show", :id=> server_id ) }
      else
        format.html { redirect_to(:controller => 'servers', :action => "show", :id=> server_id ) }
      end
    end
  end

end