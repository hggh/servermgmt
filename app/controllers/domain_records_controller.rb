class DomainRecordsController < ApplicationController
  def destroy
    @domain_record = DomainRecord.find(params[:id])
    @domain = Domain.find(params[:domain_id])
    @domain_record.destroy
    respond_to do |format|
      flash[:notice] = 'Domain Record was successully destroyed!'
      format.html { redirect_to(@domain ) }
    end
  end

  def new
    @domain = Domain.find(params[:domain_id])
    @domain_record = DomainRecord.new
    respond_to do |format|
      format.html
    end
  end
end