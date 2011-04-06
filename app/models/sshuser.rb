class Sshuser < ActiveRecord::Base
  validates :username, :presence => true, :uniqueness => { :scope => :server_id }
  validates :server_id, :presence => true

  belongs_to :server
  has_many :sshuser_mbrs, :dependent => :destroy


  def self.allByServerByUser
    @sshusers =  Sshuser.all
    @sshusers.sort_by { |s| [ s.server.domain.name ,s.server.name,s.username ] }
  end

  def getSSHMemberKeys
    users = sshuser_mbrs.where('sshkey_group_id IS NULL ')
  end

  def getSSHGroupMemberKeys
    users = sshuser_mbrs.where('sshkey_id IS NULL')
  end
end
