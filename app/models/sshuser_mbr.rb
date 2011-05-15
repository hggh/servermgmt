class SshuserMbr < ActiveRecord::Base
  validates :sshuser_id, :presence => true
  validates_uniqueness_of :sshuser_id, :scope =>  [ :sshkey_id, :sshkey_group_id ]


  belongs_to :sshuser
  belongs_to :sshkey
  belongs_to :sshkey_group


  def key?
    return true if sshkey_id
    false
  end

  def group?
    return true if sshkey_group_id
    false
  end

end
