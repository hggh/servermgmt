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

  # Get's all Groups that the sshkey_id is NOT an Member
  def self.getGroupsNotKeyMember(sshkey_id)
    SshkeyGroup.find_by_sql ["select * from sshkey_groups where id NOT IN (select sshkey_group_id from sshkey_group_mbrs where sshkey_id = ?)", sshkey_id]
  end
end
