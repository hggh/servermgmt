class SettingsController < ApplicationController
  def index
    @settings = Setting.find(:all)
  end
  
  def edit
    @setting = Setting.find(params[:id])
  end
  
  def update
    @setting = Setting.find(params[:id])

    respond_to do |format|
      if @setting.update_attributes(params[:setting])
        flash[:notice] = 'Setting was successfully updated.'
        format.html { redirect_to(settings_path()) }
      else
        format.html { render :action => "edit" }
      end
    end
  end  
end