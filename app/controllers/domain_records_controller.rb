class DomainRecordsController < ApplicationController
  def destroy
    @domain_record = DomainRecord.find(params[:id])
    domain_id = @domain_record.domain_id
    @domain_record.destroy
    respond_to do |format|
      flash[:notice] = 'Domain Record was successully destroyed!'
      format.html { redirect_to(:controller => 'domains', :action => "show", :id=> domain_id ) }
    end
  end
end