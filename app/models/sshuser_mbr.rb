class SshuserMbr < ActiveRecord::Base
  validates :sshuser_id, :presence => true, :association => true, :uniqueness => { :scope =>  [ :sshkey_id, :sshkey_group_id ] }
  validates :sshkey_id, :association => true
  validates :sshkey_group_id, :association => true

  belongs_to :sshuser
  belongs_to :sshkey
  belongs_to :sshkey_group

  def key?
    return true if sshkey_id and sshkey
    false
  end

  def group?
    return true if sshkey_group_id
    false
  end

end
