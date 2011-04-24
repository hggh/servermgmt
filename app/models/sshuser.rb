class Sshuser < ActiveRecord::Base
  validates :username, :presence => true, :uniqueness => { :scope => :server_id }
  #validates :server_group_id, :presence => true
  #validates :server_id, :presence => true
  # FIXME

  belongs_to :server
  belongs_to :server_group
  has_many :sshuser_mbrs, :dependent => :destroy


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
