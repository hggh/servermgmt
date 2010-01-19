class HomeController < ApplicationController
  def index
  end

  def settings
     respond_to do |format|
      format.html # show.html.erb
    end   
  end

end
