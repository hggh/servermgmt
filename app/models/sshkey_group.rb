class SshkeyGroup < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  has_many :sshkey_group_mbrs, :dependent => :destroy

  def membercount
    sshkey_group_mbrs.count
  end
end
