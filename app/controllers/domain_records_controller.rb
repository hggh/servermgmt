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

  def edit
    @domain = Domain.find(params[:domain_id])
    @domain_record = DomainRecord.find(params[:id])
  end

  def new
    @domain = Domain.find(params[:domain_id])
    @domain_record = DomainRecord.new
    if @domain.isReverseZone and @domain_record.domain_record_type_id == nil
      @domain_record.domain_record_type_id = 11
    end
    if @domain_record.ttl == nil
      @domain_record.ttl = Setting.get('dns_default_record_ttl')
    end
    respond_to do |format|
      format.html
    end
  end

  def update
    @domain_record = DomainRecord.find(params[:id])
    @domain = Domain.find(params[:domain_id])
    respond_to do |format|
      if @domain_record.update_attributes(params[:domain_record])
        flash[:notice] = 'Domain Record was successfully updated.'
        format.html { redirect_to(@domain) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def create
    @domain_record = DomainRecord.new(params[:domain_record])
    @domain = Domain.find(params[:domain_id])

    respond_to do |format|
      if @domain_record.save
        flash[:notice] = 'Record was successfully created.'
        format.html { redirect_to(@domain) }
      else
        format.html { render :action => "new" }
      end
    end
  end
end