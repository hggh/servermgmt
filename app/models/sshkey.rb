class Sshkey < ActiveRecord::Base
  default_scope :order => 'name'


  validates :name, :presence => true, :uniqueness => true
  validates :key_public, :presence => true

  has_many :sshkey_group_mbrs, :dependent => :destroy
  has_many :sshkey_groups, :through => :sshkey_group_mbrs
  has_many :sshuser_mbrs, :dependent => :destroy

  def self.allNotInGroup(group_id)
    users = Array.new
    Sshkey.all.each do |u|
      if u.inGroup?(group_id) == false
        users << u
      end
    end
    users
  end

  def key_public_auth
    "ssh-rsa #{key_public} #{name}"
  end

  def inGroup?(sid)
    return true if sshkey_group_mbrs.where(:sshkey_group_id => sid).count > 0
    false
  end

  def group_names
    groups = Array.new
    sshkey_groups.each do |group|
      groups << group.name
    end
    groups
  end
end
