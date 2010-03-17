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
end