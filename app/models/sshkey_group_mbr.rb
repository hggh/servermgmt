class SshkeyGroupMbr < ActiveRecord::Base
  validates :sshkey_id, :presence => true, :association => true, :uniqueness => { :scope => :sshkey_group_id }
  validates :sshkey_group_id, :presence => true, :association => true


  belongs_to :sshkey, :validate => true
  belongs_to :sshkey_group, :validate => true
end
