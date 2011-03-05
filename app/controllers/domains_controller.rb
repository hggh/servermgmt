class DomainsController < ApplicationController
  def index
    @domains = Domain.find(:all)
    
    respond_to do |format|
      format.html
    end
  end
  
  def show
    @domain = Domain.find(params[:id])
    respond_to do |format|
      format.html
    end
  end
  
  def new
    @domain = Domain.new
    @nameservers = Nameserver.find(:all)
    @domain_nameserver_pri = DomainNameserver.new
    @domain_nameserver_sec = DomainNameserver.new

    respond_to do |format|
      format.html
    end
    
  end
  
  def create
    @nameservers = Nameserver.find(:all)
    if params[:domain][:domain_nameserver_pri_attributes]
      @domain_nameserver_pri = DomainNameserver.new(params[:domain][:domain_nameserver_pri_attributes])
      params[:domain].delete("domain_nameserver_pri_attributes")
    end
    if params[:domain][:domain_nameserver_sec_attributes]
      @domain_nameserver_sec = DomainNameserver.new(params[:domain][:domain_nameserver_sec_attributes])
      params[:domain].delete("domain_nameserver_sec_attributes")
    end
    @domain = Domain.new(params[:domain])

    respond_to do |format|
      if @domain.save
        if @domain_nameserver_pri and @domain_nameserver_pri.nameserver_id and @domain_nameserver_pri.nameserver_id.to_s =~ /^[0-9]+$/
          @nameserver = Nameserver.find(@domain_nameserver_pri.nameserver_id.to_i)
          if @nameserver
            ns_pri = Hash.new
            ns_pri['domain_id'] = @domain.id
            ns_pri['nameserver_id'] = @nameserver.id
            ns_pri['primary_ns'] = 'true'
            ns_pri['ns_entry'] = 1
            ns_pri_save = DomainNameserver.new(ns_pri)
            ns_pri_save.save
          end
        end
        if @domain_nameserver_sec and @domain_nameserver_sec.nameserver_id and @domain_nameserver_sec.nameserver_id.to_s =~ /^[0-9]+$/
          @nameserver = Nameserver.find(@domain_nameserver_sec.nameserver_id.to_i)
          if @nameserver
            ns_sec = Hash.new
            ns_sec['domain_id'] = @domain.id
            ns_sec['nameserver_id'] = @nameserver.id
            ns_sec['primary_ns'] = 'false'
            ns_sec['ns_entry'] = 1
            ns_sec_save = DomainNameserver.new(ns_sec)
            ns_sec_save.save
          end
        end
        # Bump up serial first time - so NS get's notified
        @domain.touch
        flash[:notice] = 'Domain was successfully created.'
        format.html { redirect_to(@domain ) }
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
