class ServerGroup < ActiveRecord::Base
	default_scope :order => :name
	validates_presence_of :name
	validates_length_of :name, :minimum => 3
  validates_uniqueness_of :name
  # FIXME: Check regex with Regexp

	has_many :server_group_members, :dependent => :destroy
	has_many :sshusers, :dependent => :destroy
  
  def getServerNotinGroup
    Server.find(:all, :joins => " LEFT JOIN (SELECT * FROM server_group_members WHERE server_group_id= #{id}) AS tmp ON tmp.server_id = servers.id", :conditions => "tmp.id IS NULL")
  end

end
