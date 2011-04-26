class SshkeymgmtsController < ApplicationController
  def index
    @sshkeys = Sshkey.find(:all)
    @sshkey_groups = SshkeyGroup.find(:all)
  end
end