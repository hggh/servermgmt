class SshkeyGroup < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  has_many :sshkey_group_mbrs, :dependent => :destroy
  has_many :sshuser_mbrs, :dependent => :destroy

  def getKeysFromMembers
    keys = Array.new
    sshkey_group_mbrs.each do |mb|
      keys << mb.sshkey.key_public_auth
    end
    keys
  end

  def membercount
    sshkey_group_mbrs.count
  end
end
