class SearchController < ApplicationController
  require 'ipaddr'
  def index
    @question = params[:q] || ""
    @question.strip!
    ipaddress = false
    
    begin
       ipaddr = IPAddr.new @question
       if ipaddr.ipv4? or ipaddr.ipv6?
         ipaddress = true
       end
    rescue
      #do nothing
    end
    if ipaddress 
      @ips = Ip.find(:all, :conditions => ["ip = ?",  @question ])
      if @ips.count == 1
        @ip = Ip.find(:last,@ips)
        redirect_to(:controller => 'servers', :action => "show", :id => @ip.server_id )
      end
    else
      @servers = Server.find(:all,:conditions => ["name LIKE ?", '%' + @question +'%' ])
    end
  end
end