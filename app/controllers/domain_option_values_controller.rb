class DomainOptionValuesController < ApplicationController
  def destroy
    @domain = Domain.find(params[:domain_id])
    @domain_option_value = DomainOptionValue.find(params[:id])
    @domain_option_value.destroy
    
    respond_to do |format|
      flash[:notice] = 'Domain Option was successfully deleted.'
      format.html { redirect_to(@domain) }
    end
  end

  def new
    @domain = Domain.find(params[:domain_id])
    @domain_option_value = DomainOptionValue.new
  end

  def create
    @domain = Domain.find(params[:domain_id])
    @domain_option_value = DomainOptionValue.new(params[:domain_option_value])

    respond_to do |format|
      if @domain_option_value.save
        flash[:notice] = 'Domain Option was successfully created.'
        format.html { redirect_to(@domain) }
      else
        format.html { render :action => "new" }
      end
    end
  end
end
