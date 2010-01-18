class DomainsController < ApplicationController
  def index
    @domains = Domain.find(:all)
    
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  def show
    @domain = Domain.find(params[:id])
    respond_to do |format|
      format.html
    end
    rescue ActiveRecord::RecordNotFound
      render_404
  end
  
  def new
    @domain = Domain.new

    respond_to do |format|
      format.html
    end
    
  end
  
  def create
    @domain = Domain.new(params[:domain])
    
    respond_to do |format|
      if @domain.save
        flash[:notice] = 'Domain was successfully created.'
        format.html { redirect_to(:controller => 'domains' ) }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def edit
    @domain = Domain.find(params[:id])
  end
  
  def destroy
    @domain = Domain.find(params[:id])
    @domain.destroy

    respond_to do |format|
      format.html { redirect_to(domains_url) }
    end
  end
  def update
    @domain = Domain.find(params[:id])

    respond_to do |format|
      if @domain.update_attributes(params[:domain])
        flash[:notice] = 'Domain was successfully updated.'
        format.html { redirect_to(@domain) }
      else
        format.html { render :action => "edit" }
      end
    end
  end  
end
