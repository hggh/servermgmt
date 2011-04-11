class SshkeyGroupMbrsController < ApplicationController

  def destroy
    @sshkey_group = SshkeyGroup.find(params[:sshkey_group_id])
    @sshkey_group_mbr = SshkeyGroupMbr.find(params[:id])
    
    @sshkey_group_mbr.destroy

    respond_to do |format|
      format.html { redirect_to(sshkey_group_url(@sshkey_group) ) }
    end
  end

  def create
    @sshkey_group = SshkeyGroup.find(params[:sshkey_group_id])
    @sshkey_group_mbr = SshkeyGroupMbr.new(params[:sshkey_group_mbr])
    @sshkey_group_mbr.sshkey_group_id = @sshkey_group.id

    respond_to do |format|
      if @sshkey_group_mbr.save
        format.html { redirect_to(@sshkey_group, :notice => 'SSH Key Group Member was successfully created.') }
      else
        # FIXME
        #format.html { render :con,  :action => "new" }
      end
    end
  end

end