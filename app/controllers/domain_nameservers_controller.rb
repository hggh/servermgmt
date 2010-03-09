class DomainNameserversController < ApplicationController
  def destroy
    @domain_nameserver = DomainNameserver.find(params[:id])
    @domain = Domain.find(params[:domain_id])
    @domain_nameserver.destroy
    respond_to do |format|
      flash[:notice] = 'Domain Nameserver was successully destroyed!'
      format.html { redirect_to(@domain ) }
    end
  end

  def new
    @domain = Domain.find(params[:domain_id])
    @domain_nameserver = DomainNameserver.new
    # if no primary NS exists, force to true, so user don't have to click :)
    if ! @domain.getMaster
      @domain_nameserver.primary_ns = true
    end
    respond_to do |format|
      format.html
    end
  end

  def create
    @domain_nameserver = DomainNameserver.new(params[:domain_nameserver])
    @domain = Domain.find(@domain_nameserver.domain_id)
    respond_to do |format|
      if @domain_nameserver.save
        flash[:notice] = 'Domain Nameserver was successfully created.'
        format.html { redirect_to(@domain_nameserver.domain) }
      else
        format.html { render :action => "new" }
      end
    end
  end

end