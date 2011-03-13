class SshuserMbr < ActiveRecord::Base
  validates :sshuser_id, :presence => true

  belongs_to :sshuser
  belongs_to :sshkey
  belongs_to :ssh_group
end
