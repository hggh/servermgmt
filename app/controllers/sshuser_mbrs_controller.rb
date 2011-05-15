class SshuserMbrsController < ApplicationController
  def destroy
    @sshuser    = Sshuser.find(params[:sshuser_id])
    @sshusermbr = SshuserMbr.find(params[:id])
    @sshusermbr.destroy

    @ajax_div = ""
    if params[:ajax_div]
      @ajax_div = params[:ajax_div]
    end
    if @sshuser.server
      @server = @sshuser.server
    else
      @server_group = @sshuser.server_group
    end


    respond_to do |format|
      format.html { redirect_to(sshuser_url(@sshuser) ) }
      format.js { render :layout => false }
    end
  end

  def create
    @sshuser = Sshuser.find(params[:sshuser_id])
    @sshusermbr = SshuserMbr.new(params[:sshuser_mbr])

    @ajax_div = ""
    if params[:ajax_div]
      @ajax_div = params[:ajax_div]
    end


    respond_to do |format|
      if @sshusermbr.save
        if @sshusermbr.sshuser.server
          @server = @sshusermbr.sshuser.server
        else
          @server_group = @sshusermbr.sshuser.server_group
        end
        format.html { redirect_to(@sshuser, :notice => 'Sshuser Member was successfully created.') }
        format.js { render :layout => false }
      else
        format.js { render :layout => false }
        # FIXME
        #format.html { render :con,  :action => "new" }
      end
    end
  end  
end