class SshuserMbrsController < ApplicationController
  def destroy
    @sshuser    = Sshuser.find(params[:sshuser_id])
    @sshusermbr = SshuserMbr.find(params[:id])
    @sshusermbr.destroy

    respond_to do |format|
      format.html { redirect_to(sshuser_url(@sshuser) ) }
      format.js { render :layout => false }
    end
  end

  def create
    @sshuser = Sshuser.find(params[:sshuser_id])
    @sshusermbr = SshuserMbr.new(params[:sshuser_mbr])

    respond_to do |format|
      if @sshusermbr.save
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