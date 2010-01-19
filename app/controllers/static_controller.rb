class StaticController < ApplicationController
  def page
    # FIXME: check if file exists and use params[:id]
    render :template => "home/settings", :layout => 'default'
  end
end