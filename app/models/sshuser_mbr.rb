class SshuserMbr < ActiveRecord::Base
  validates :sshuser_id, :presence => true

  belongs_to :sshuser
  belongs_to :sshkey
  belongs_to :sshkey_group
  # FIXME: an sshkey can only be once
  # FIXME: an sshkeygroup can only be once
end
