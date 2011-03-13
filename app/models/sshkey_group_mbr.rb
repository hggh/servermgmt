class SshkeyGroupMbr < ActiveRecord::Base
  validates :sshkey_id, :presence => true
  validates :sshkey_group_id, :presence => true

  belongs_to :sshkey
  belongs_to :sshkey_group
end
