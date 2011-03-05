class NameserversController < ApplicationController
  # FIXME: We want to filter via IP
  skip_before_filter :login_required, :only => [ 'getconfig' ] 
  def index
    @nameservers = Nameserver.find(:all)

    respond_to do |format|
      format.html
    end
  end

  def getconfig
    @config = Hash.new
    @nameserver = Nameserver.find(:first, :conditions => [ "name = ?", params[:nameserver_name] ])
    if @nameserver == nil
      raise "Nameserver not found."
    end

    case params[:server_system]
      when 'bind'
        @config["server_system"] = 'bind'
      else
        @config['server_system'] = 'bind'
    end
    case params[:nameserver_config]
      when 'zone'
        @config['server_config'] = 'zone'
      else
        @config['server_config'] = 'config'
    end
    render :action => @config['server_system'] + '_' + @config['server_config'], :layout => false, :content_type => 'text/plain'
  end

  def show
    @nameserver = Nameserver.find(params[:id])

    respond_to do |format|
      format.html
    end
  end
  
  def new
    @nameserver = Nameserver.new

    respond_to do |format|
      format.html
    end
  end

  def edit
    @nameserver = Nameserver.find(params[:id])
  end

  def create
    @nameserver = Nameserver.new(params[:nameserver])

    respond_to do |format|
      if @nameserver.save
        flash[:notice] = 'Nameserver was successfully created.'
        format.html { redirect_to(@nameserver) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @nameserver = Nameserver.find(params[:id])

    if Setting.get("mcollective_nameserver") != "true"
      @nameserver.mcollective_host = nil
    end

    respond_to do |format|
      if @nameserver.update_attributes(params[:nameserver])
        flash[:notice] = 'Nameserver was successfully updated.'
        format.html { redirect_to(@nameserver) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @nameserver = Nameserver.find(params[:id])
    @nameserver.destroy

    respond_to do |format|
      format.html { redirect_to(nameservers_url) }
    end
  end

end