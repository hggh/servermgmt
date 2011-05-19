class SshkeymgmtsController < ApplicationController
  def index
    @sshkeys = Sshkey.find(:all)
    @sshkey_groups = SshkeyGroup.find(:all)

    @sshusers_servers = Sshuser.getUsersByServers
    @sshusers_servergroups = Sshuser.getUsersByServerGroups

  end
end