class SshuserMbr < ActiveRecord::Base
  validates :sshuser_id, :presence => true
  validates_uniqueness_of :sshuser_id, :scope =>  [ :sshkey_id, :sshkey_group_id ]


  belongs_to :sshuser
  belongs_to :sshkey
  belongs_to :sshkey_group

end
