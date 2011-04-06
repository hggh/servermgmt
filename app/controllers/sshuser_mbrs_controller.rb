class SshuserMbrsController < ApplicationController
  def destroy
    @sshuser    = Sshuser.find(params[:sshuser_id])
    @sshusermbr = SshuserMbr.find(params[:id])
    @sshusermbr.destroy

    respond_to do |format|
      format.html { redirect_to(sshuser_url(@sshuser) ) }
    end
  end

  def create
    @sshuser = Sshuser.find(params[:sshuser_id])
    @sshusermbr = SshuserMbr.new(params[:sshuser_mbr])

    respond_to do |format|
      if @sshusermbr.save
        format.html { redirect_to(@sshuser, :notice => 'Sshuser Member was successfully created.') }
      else
        # FIXME
        #format.html { render :con,  :action => "new" }
      end
    end
  end  
end