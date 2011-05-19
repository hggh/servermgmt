class SshkeyGroupMbr < ActiveRecord::Base
  validates :sshkey_id, :presence => true, :association => true
  validates :sshkey_group_id, :presence => true, :association => true

  validates :sshkey_id, :uniqueness => { :scope => :sshkey_group_id }


  belongs_to :sshkey, :validate => true
  belongs_to :sshkey_group, :validate => true
end
