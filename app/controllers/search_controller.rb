class SearchController < ApplicationController
  require 'ipaddr'
  def index
    @question = params[:q] || ""
    @question.strip!
    @question_type = params[:question_type] || ""
    ipaddress = false
    
    if Setting.get('puppet') == "true" and @question_type=~/^(facts|fact_values)/
      if @question_type == "fact_values"
        @fact_values = FactValue.find(:all, :include => :host, :order => "hosts.name ASC" ,:conditions => ["value LIKE ?", '%' + @question + '%'])
      else
        @facts = FactName.find(:all, :conditions => ["fact_names.name LIKE ? ", '%' + @question + '%'])
      end
    else  
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
    
    # Puppet Facts / Fact_Values
    end
  end
end