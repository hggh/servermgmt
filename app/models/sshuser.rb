class Sshuser < ActiveRecord::Base
  validates :username, :presence => true, :uniqueness => { :scope => :server_id }
  #validates :server_group_id, :presence => true
  #validates :server_id, :presence => true
  # FIXME

  belongs_to :server
  belongs_to :server_group
  has_many :sshuser_mbrs, :dependent => :destroy


  def self.getUsersByServers
    sshusers_server_ids = Sshuser.select('server_id').where("server_id IS NOT NULL").group("server_id").map { |d| d.server_id}
    @sshusers_servers = Server.includes(:domain).where(:id => sshusers_server_ids).order("domains.name ASC").order('servers.name ASC')
  end

  def self.getUsersByServerGroups
    sshusers_server_groups_ids = Sshuser.select('server_group_id').where("server_group_id IS NOT NULL").group("server_group_id").map { |d| d.server_group_id}
    @sshusers_servergroups = ServerGroup.where(:id => sshusers_server_groups_ids).order("name ASC")
  end

  def self.allByServerByUser
    @sshusers =  Sshuser.all
  end

  def getSSHMemberKeys
    users = sshuser_mbrs.where('sshkey_group_id IS NULL ')
  end

  def getSSHGroupMemberKeys
    users = sshuser_mbrs.where('sshkey_id IS NULL')
  end
end
