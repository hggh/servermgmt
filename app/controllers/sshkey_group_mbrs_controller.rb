class SshkeyGroupMbrsController < ApplicationController

  def destroy
    @sshkey_group = SshkeyGroup.find(params[:sshkey_group_id])
    @sshkey_group_mbr = SshkeyGroupMbr.find(params[:id])
    sshkey_id = @sshkey_group_mbr.sshkey_id
    @sshkey_group_mbr.destroy

    @ajax_from = params[:ajax_from] if params[:ajax_from]

    if @ajax_from == "sshkey_show"
      @sshkey = Sshkey.find(sshkey_id)
    end

    respond_to do |format|
      format.html { redirect_to(sshkey_group_url(@sshkey_group) ) }
      format.js { render :layout => false }
    end
  end

  def create

    @sshkey_group_mbr = SshkeyGroupMbr.new(params[:sshkey_group_mbr])

    #@sshkey_group = SshkeyGroup.find(params[:sshkey_group_id])
    #@sshkey_group_mbr.sshkey_group_id = @sshkey_group.id

    @ajax_from = params[:ajax_from] if params[:ajax_from]

    if @ajax_from == "sshkey_show"
      @sshkey = Sshkey.find(@sshkey_group_mbr.sshkey_id)
    end

    respond_to do |format|
      if @sshkey_group_mbr.save
        format.html { redirect_to(@sshkey_group, :notice => 'SSH Key Group Member was successfully created.') }
        format.js { render :layout => false }
      else
        format.js { render :layout => false }
        # FIXME
        #format.html { render :con,  :action => "new" }
      end
    end
  end

end