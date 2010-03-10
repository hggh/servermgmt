class DomainSoasController < ApplicationController
  def edit
    @domain = Domain.find(params[:domain_id])
    @domain_soa = DomainSoa.find(params[:id])
  end

  def new
    @domain = Domain.find(params[:domain_id])
    @domain_soa = DomainSoa.new
    # If Domain has got already an primary DNS; Add name to SOA record
    if @domain.getMaster and !@domain_soa.primary_ns
      master_ns = @domain.getMaster
      @domain_soa.primary_ns = master_ns.nameserver.name
    end
  end

  def create
    @domain = Domain.find(params[:domain_id])
    @domain_soa = DomainSoa.new(params[:domain_soa])
    @domain_soa.domain_id = @domain.id
    
    respond_to do |format|
      if @domain_soa.save
        flash[:notice] = 'Domain SOA was successfully created.'
        format.html { redirect_to(@domain ) }
      else
        format.html { render :action => "new" }
      end
    end    
  end

  def update
    @domain = Domain.find(params[:domain_id])
    @domain_soa = DomainSoa.find(params[:id])

    respond_to do |format|
      if @domain_soa.update_attributes(params[:domain_soa])
        flash[:notice] = 'Domain SOA was successfully updated.'
        format.html { redirect_to(@domain) }
      else
        format.html { render :action => "edit" }
      end
    end    
  end

  def destroy
    @domain = Domain.find(params[:domain_id])
    @domain_soa = DomainSoa.find(params[:id])
    @domain_soa.destroy

    respond_to do |format|
      format.html { redirect_to(@domain) }
    end
  end
end