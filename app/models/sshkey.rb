class Sshkey < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  validates :key_public, :presence => true

  has_many :sshkey_group_mbrs, :dependent => :destroy
  has_many :sshkey_groups, :through => :sshkey_group_mbrs


  def group_names
    groups = Array.new
    sshkey_groups.each do |group|
      groups << group.name
    end
    groups
  end
end
